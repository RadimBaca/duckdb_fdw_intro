# Duckdb_fdw Intro

This example shows the basic usage of the duckdb_fdw extension in Postgres. 
We use a docker image with preinstalled PostgreSQL and Duckdb_fdw extension. 
To simulate my environment, run the following docker commands. 
Of course, you must have [docker](https://www.docker.com/) up and running on your host machine.

```bash
docker run --name postgre_duckdb_demo -e POSTGRES_PASSWORD=strong_pass -d -p 5432:5432  chumaky/postgres_duckdb_fdw
docker exec -it --user postgres postgre_duckdb_demo /bin/bash
```

Once you run the `docker exec` command, you need to create `duckdb` directory in `/var/lib/postgresql/data`.
Connect to the postgres using your favorite client and you can start testing commands from `postgres.sql`.
