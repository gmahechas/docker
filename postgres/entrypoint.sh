#!/bin/bash
set -e  # exit on error

# run
exec /usr/local/bin/docker-entrypoint.sh "$@"

# change permissions
chown postgres:postgres /var/lib/postgresql/data/ssl/server.key
chmod 600 /var/lib/postgresql/data/ssl/server.key


# include custom configs
PG_CONF="/var/lib/postgresql/data/pgdata/postgresql.conf"
PG_HBA="/var/lib/postgresql/data/pgdata/pg_hba.conf"
echo "include = 'postgresql.custom.conf'" >> "$PG_CONF"
echo "include = 'pg_hba.custom.conf'" >> "$PG_HBA"

wait