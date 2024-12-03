# fcc_rdb_periodic_table_database

## Instructions
1. Edit dump sql file from github freecode camp: Comment DROP DATABASE and CREATE DATABASE from sql file
### psql terminal
2. Connect to postgres: psql -U postgres -h localhost
3. insert 1010 as password
4. CREATE DATABASE <database_name>;
5. CREATE DATABASE periodic_table;
### bash terminal
6. Import sql dump from bash terminal: psql -U -d -f <dump_file.sql>
7. e.g. psql -U postgres -d periodic_table -f periodic_table.sql
8. replace PSQL variable with: export PGPASSWORD=1010 PSQL="psql --username=postgres --dbname=periodic_table -t --no-align -c"
