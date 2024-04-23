#!/bin/bash
set -e  # exit on error

# change permissions
chown postgres:postgres /var/lib/postgresql/data/ssl/server.key
chmod 600 /var/lib/postgresql/data/ssl/server.key


# include custom configs
PG_CONF="/var/lib/postgresql/data/pgdata/postgresql.conf"
PG_HBA="/var/lib/postgresql/data/pgdata/pg_hba.conf"
while [ ! -f "$PG_CONF" ] || [ ! -f "$PG_HBA" ]; do
    echo "waiting for postgres to start..."
    sleep 1
done

echo "include = 'postgresql.custom.conf'" >> "$PG_CONF"
echo "include = 'pg_hba.custom.conf'" >> "$PG_HBA"

# run
exec /usr/local/bin/docker-entrypoint.sh "$@"