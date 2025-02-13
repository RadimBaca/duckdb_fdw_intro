CREATE EXTENSION duckdb_fdw;

CREATE SERVER duckdb_server
FOREIGN DATA WRAPPER duckdb_fdw
OPTIONS (database '/var/lib/postgresql/data/duckdb/test.db');

SELECT duckdb_execute('duckdb_server',
    'CREATE TABLE IMDB AS SELECT * FROM read_csv_auto(''hf://datasets/ArchaeonSeq/MovieImdb/df.csv'')');

DROP FOREIGN TABLE IF EXISTS "IMDB";
DROP FOREIGN TABLE IF EXISTS "IMDB_csv";
DROP FOREIGN TABLE IF EXISTS "IMDB_copy";

IMPORT FOREIGN SCHEMA main
FROM SERVER duckdb_server
INTO public;

SELECT * FROM "IMDB" LIMIT 10;

CREATE TABLE IMDB_copy AS SELECT * FROM "IMDB";

COPY IMDB_copy TO '/var/lib/postgresql/data/duckdb/IMDB_copy.csv' DELIMITER ',' CSV HEADER;

SELECT duckdb_execute('duckdb_server',
    'CREATE TABLE IMDB_copy AS SELECT * FROM read_csv_auto(''/var/lib/postgresql/data/duckdb/IMDB_copy.csv'')');

SELECT duckdb_execute('duckdb_server',
    'CREATE VIEW IMDB_csv AS SELECT * FROM read_csv_auto(''/var/lib/postgresql/data/duckdb/IMDB_copy.csv'')');

SELECT count(*) FROM IMDB_copy;

SELECT duckdb_execute('duckdb_server',
    'COPY IMDB TO ''/var/lib/postgresql/data/duckdb/imdb.parquet'' (FORMAT ''parquet'')');

SELECT duckdb_execute('duckdb_server',
    'CREATE VIEW IMDB_parquet AS SELECT * FROM ''/var/lib/postgresql/data/duckdb/imdb.parquet''');


SELECT "startYear", COUNT(*) movie_count
FROM "IMDB"
WHERE genres LIKE '%Horror%'
GROUP BY "startYear";

SELECT "startYear", COUNT(*) movie_count
FROM IMDB_copy
WHERE genres LIKE '%Horror%'
GROUP BY "startYear";

SELECT "startYear", COUNT(*) movie_count
FROM "IMDB_csv"
WHERE genres LIKE '%Horror%'
GROUP BY "startYear";

SELECT "startYear", COUNT(*) movie_count
FROM "IMDB_parquet"
WHERE genres LIKE '%Horror%'
GROUP BY "startYear";