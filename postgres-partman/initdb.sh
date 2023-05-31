#!/bin/bash -e

echo "Creating partman extension on $PARTMAN_SCHEMA schema"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-SQL
    CREATE SCHEMA IF NOT EXISTS "$PARTMAN_SCHEMA";
    CREATE EXTENSION pg_partman SCHEMA "$PARTMAN_SCHEMA";
SQL


echo "Updating postgresql.conf"
cat >> "${PGDATA}/postgresql.conf" <<EOF
shared_preload_libraries = 'pg_partman_bgw'
pg_partman_bgw.interval = ${PG_PARTMAN_BGW_INTERVAL}
pg_partman_bgw.role = '${POSTGRES_USER}'
pg_partman_bgw.dbname = '${POSTGRES_DB}'
EOF
