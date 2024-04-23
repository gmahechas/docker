#!/bin/sh
set -e  # exit on error

# change permissions
chown postgres:postgres /var/lib/postgresql/data/ssl/server.key
chmod 600 /var/lib/postgresql/data/ssl/server.key

# include custom configs
echo "include = 'postgresql.custom.conf'" >> /var/lib/postgresql/data/pgdata/postgresql.conf
echo "include = 'pg_hba.custom.conf'" >> /var/lib/postgresql/data/pgdata/pg_hba.conf

# run
exec /usr/local/bin/docker-entrypoint.sh "$@"