FROM docker.io/postgres:18.2

ENV PG_PARTMAN_VERSION 5.4.1-*
ENV PARTMAN_SCHEMA partman
ENV PG_PARTMAN_BGW_INTERVAL 3600
ENV PG_PARTMAN_BGW_DBNAME $POSTGRES_DB

RUN apt-get update && \
    # Add postgresql repository
    apt-get install -y --no-install-recommends lsb-release wget ca-certificates gnupg && \
    mkdir -p /etc/apt/keyrings && \
    wget --quiet -O /etc/apt/keyrings/pgdg.asc https://www.postgresql.org/media/keys/ACCC4CF8.asc && \
    echo "deb [signed-by=/etc/apt/keyrings/pgdg.asc] http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    apt-get update && \
    # Install pg_partman
    apt-get install -y --no-install-recommends postgresql-18-partman=${PG_PARTMAN_VERSION} && \
    apt-get remove -y lsb-release wget && \
    rm -rf /var/lib/apt/lists/*

# Copy the init script
# The Docker Postgres initd script will run anything
# in the directory /docker-entrypoint-initdb.d
COPY initdb.sh /docker-entrypoint-initdb.d/initdb.sh
