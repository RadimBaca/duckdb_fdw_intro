# duckdb_fdw_intro

This example shows basic usage of the duckdb_fdw extension in Postgres. 
We use docker image with preinstaled PostgreSQL and Duckdb_fdw extension. 
In order to simulate my environment run the following docker commands. 
Of course you need to have [docker](https://www.docker.com/) up and running in your host machine.

```bash
docker run --name postgre_duckdb_demo -e POSTGRES_PASSWORD=strong_pass -d -p 5432:5432  chumaky/postgres_duckdb_fdw
docker exec -it --user postgres postgre_duckdb_demo /bin/bash
```

Once you run the `docker exec` command, you need to create `duckdb` directory in `/var/lib/postgresql/data`.
Connect to the postgres using your favorite client and you can start testing commands from `postgres.sql`.