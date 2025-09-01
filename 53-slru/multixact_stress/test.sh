echo "multixact_local_cache_entries = 256" >> ~/DemoDb/postgresql.conf

echo "multixact_offsets_slru_buffers = 4096" >> ~/DemoDb/postgresql.conf
echo "multixact_members_slru_buffers = 8192" >> ~/DemoDb/postgresql.conf
/Users/x4mmm/project/bin/pg_ctl -D ~/DemoDb restart
echo "4096, 8192" >> testresults.txt
./main >> testresults.txt


echo "multixact_offsets_slru_buffers = 2" >> ~/DemoDb/postgresql.conf
echo "multixact_members_slru_buffers = 4" >> ~/DemoDb/postgresql.conf
/Users/x4mmm/project/bin/pg_ctl -D ~/DemoDb restart
echo "2, 4" >> testresults.txt
./main >> testresults.txt

echo "multixact_offsets_slru_buffers = 4" >> ~/DemoDb/postgresql.conf
echo "multixact_members_slru_buffers = 8" >> ~/DemoDb/postgresql.conf
/Users/x4mmm/project/bin/pg_ctl -D ~/DemoDb restart
echo "4, 8" >> testresults.txt
./main >> testresults.txt

echo "multixact_offsets_slru_buffers = 8" >> ~/DemoDb/postgresql.conf
echo "multixact_members_slru_buffers = 16" >> ~/DemoDb/postgresql.conf
/Users/x4mmm/project/bin/pg_ctl -D ~/DemoDb restart
echo "8, 16" >> testresults.txt
./main >> testresults.txt


echo "multixact_offsets_slru_buffers = 16" >> ~/DemoDb/postgresql.conf
echo "multixact_members_slru_buffers = 32" >> ~/DemoDb/postgresql.conf
/Users/x4mmm/project/bin/pg_ctl -D ~/DemoDb restart
echo "16, 32" >> testresults.txt
./main >> testresults.txt


echo "multixact_offsets_slru_buffers = 32" >> ~/DemoDb/postgresql.conf
echo "multixact_members_slru_buffers = 64" >> ~/DemoDb/postgresql.conf
/Users/x4mmm/project/bin/pg_ctl -D ~/DemoDb restart
echo "32, 64" >> testresults.txt
./main >> testresults.txt

echo "multixact_offsets_slru_buffers = 64" >> ~/DemoDb/postgresql.conf
echo "multixact_members_slru_buffers = 128" >> ~/DemoDb/postgresql.conf
/Users/x4mmm/project/bin/pg_ctl -D ~/DemoDb restart
echo "64, 128" >> testresults.txt
./main >> testresults.txt

echo "multixact_offsets_slru_buffers = 128" >> ~/DemoDb/postgresql.conf
echo "multixact_members_slru_buffers = 256" >> ~/DemoDb/postgresql.conf
/Users/x4mmm/project/bin/pg_ctl -D ~/DemoDb restart
echo "128, 256" >> testresults.txt
./main >> testresults.txt

echo "multixact_offsets_slru_buffers = 4096" >> ~/DemoDb/postgresql.conf
echo "multixact_members_slru_buffers = 8192" >> ~/DemoDb/postgresql.conf
/Users/x4mmm/project/bin/pg_ctl -D ~/DemoDb restart
echo "4096, 8192" >> testresults.txt
./main >> testresults.txt