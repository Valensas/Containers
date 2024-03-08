FROM docker.io/postgres:16.2

ENV PG_PARTMAN_VERSION 5.0.1-*
ENV PARTMAN_SCHEMA partman
ENV PG_PARTMAN_BGW_INTERVAL 3600
ENV PG_PARTMAN_BGW_DBNAME $POSTGRES_DB

RUN apt-get update && \
    # Add postgresql repository
    apt-get install -y --no-install-recommends lsb-release wget ca-certificates && \
    echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    apt-get update && \
    # Install pg_partman
    apt-get install -y --no-install-recommends postgresql-16-partman=${PG_PARTMAN_VERSION} && \
    apt-get remove -y lsb-release wget && \
    rm -rf /var/lib/apt/lists/*

# Copy the init script
# The Docker Postgres initd script will run anything
# in the directory /docker-entrypoint-initdb.d
COPY initdb.sh /docker-entrypoint-initdb.d/initdb.sh
