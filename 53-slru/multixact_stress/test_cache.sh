echo "multixact_offsets_slru_buffers = 8" >> ~/DemoDb/postgresql.conf
echo "multixact_members_slru_buffers = 16" >> ~/DemoDb/postgresql.conf


echo "multixact_local_cache_entries = 256" >> ~/DemoDb/postgresql.conf
/Users/x4mmm/project/bin/pg_ctl -D ~/DemoDb restart
echo "256" >> testresults.txt
./main >> testresults.txt

echo "multixact_local_cache_entries = 16" >> ~/DemoDb/postgresql.conf
/Users/x4mmm/project/bin/pg_ctl -D ~/DemoDb restart
echo "16" >> testresults.txt
./main >> testresults.txt

echo "multixact_local_cache_entries = 32" >> ~/DemoDb/postgresql.conf
/Users/x4mmm/project/bin/pg_ctl -D ~/DemoDb restart
echo "32" >> testresults.txt
./main >> testresults.txt

echo "multixact_local_cache_entries = 64" >> ~/DemoDb/postgresql.conf
/Users/x4mmm/project/bin/pg_ctl -D ~/DemoDb restart
echo "64" >> testresults.txt
./main >> testresults.txt

echo "multixact_local_cache_entries = 128" >> ~/DemoDb/postgresql.conf
/Users/x4mmm/project/bin/pg_ctl -D ~/DemoDb restart
echo "128" >> testresults.txt
./main >> testresults.txt

echo "multixact_local_cache_entries = 256" >> ~/DemoDb/postgresql.conf
/Users/x4mmm/project/bin/pg_ctl -D ~/DemoDb restart
echo "256" >> testresults.txt
./main >> testresults.txt

echo "multixact_local_cache_entries = 512" >> ~/DemoDb/postgresql.conf
/Users/x4mmm/project/bin/pg_ctl -D ~/DemoDb restart
echo "512" >> testresults.txt
./main >> testresults.txt

echo "multixact_local_cache_entries = 1024" >> ~/DemoDb/postgresql.conf
/Users/x4mmm/project/bin/pg_ctl -D ~/DemoDb restart
echo "1024" >> testresults.txt
./main >> testresults.txt