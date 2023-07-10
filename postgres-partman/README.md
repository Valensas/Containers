# Postgres Partman

This image, based on [Postgres](https://hub.docker.com/_/postgres), adds support for [PGPartman](https://github.com/pgpartman/pg_partman).

## Usage

```bash
docker run --name my-postgres -e POSTGRES_PASSWORD=mypassword valensas/postgres-partman:15.3-4.7.2
```

## Configuration

This image provides the following environment variables:

`PARTMAN_SCHEMA`: The schema on which the partman extension will be created. It's only created for one database and defaults to `$POSTGRES_DB`.

`PG_PARTMAN_BGW_INTERVAL`: The interval at which the partman background worker should run, in seconds. Defaults to 3600.

`PG_PARTMAN_BGW_DBNAME`: The databases on which the partman background worker should run maintenance. Separate multiple databases with commas. Defaults to `$POSTGRES_DB`.

Additional configuration options are provided by the [Postgres image](https://hub.docker.com/_/postgres).