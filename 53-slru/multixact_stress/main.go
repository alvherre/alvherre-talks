package main

import (
	"fmt"
	"github.com/jackc/pgtype"
	"strconv"
	"time"
)
import "os"
import "context"
import pgx "github.com/jackc/pgx"

func main() {
	conn := SpawnConnection()
	defer conn.Close(context.Background())

	N := 1000000
	sqlc(conn, "create table if not exists t1(i int primary key) with (fillfactor = 10)")
	sqlc(conn, "truncate t1")
	sqlc(conn, "insert into t1 select generate_series(1,"+strconv.Itoa(N)+",1)")

	concurrency := 7
	conc := make(chan struct{}, concurrency)
	for i := 0; i < concurrency; i++ {
		conc <- struct{}{}
	}

	go SelectTableForever()
	go SelectTableForever()

	start := time.Now()
	for step := 0; step < 3; step++ {
		for i := 0; i < 14; i++ {
			token := <-conc
			locali := uint(i)
			go func() {
				tx := getTx()

				list := make([]int, 0)
				for n := 0; n < N; n++ {
					if (n & (1 << locali)) == 0 {
						list = append(list, n)
					}
				}
				ids := &pgtype.Int4Array{}
				ids.Set(list)
				sql(tx, "select * from t1 where i = ANY ($1) for share", ids)
				go PingTransactionForever(tx)

				conc <- token
			}()
		}
	}

	for i := 0; i < concurrency; i++ {
		<-conc
	}

	fmt.Println("Test time ", time.Now().Sub(start))
}

func sql(conn pgx.Tx, query string, args ...interface{}) {
	r, err := conn.Query(context.Background(), query, args...)
	if err != nil {
		fmt.Print(err)
		//os.Exit(1)
	}
	r.Close()
}
func sqlc(conn *pgx.Conn, query string, args ...interface{}) {
	r, err := conn.Query(context.Background(), query, args...)
	if err != nil {
		fmt.Print(err)
		//os.Exit(1)
	}
	r.Close()
}

func getTx() pgx.Tx {
	ctx := context.Background()
	conn := SpawnConnection()

	tx, err := conn.Begin(ctx)
	if err != nil {
		fmt.Print(err)
		os.Exit(1)
	}
	return tx
}

func SpawnConnection() *pgx.Conn {
	ctx := context.Background()
	conn, err := pgx.Connect(ctx, "host=127.0.0.1 port=5432 user=x4mmm database=postgres")
	if err != nil {
		fmt.Fprintf(os.Stderr, "Unable to connection to database: %v\n", err)
		os.Exit(1)
	}
	return conn
}

func PingTransactionForever(t pgx.Tx) {
	ctx := context.Background()
	for {
		time.Sleep(time.Second)
		_, err := t.Query(ctx, "select 1")
		if err != nil {
			//fmt.Print(err)
			return
			//os.Exit(1)
		}
	}
}

func SelectTableForever() {
	ctx := context.Background()
	t := getTx()
	for {
		time.Sleep(time.Second)
		_, err := t.Query(ctx, "select count(*) from t1 where i%2 = 1")
		if err != nil {
			//fmt.Print(err)
			return
			//os.Exit(1)
		}
	}
}
