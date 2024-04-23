#!/bin/sh
set -e  # exit on error

# run
exec docker-entrypoint.sh postgres

# change permissions
chown postgres:postgres /var/lib/postgresql/data/ssl/server.key

# include custom configs
echo "include = 'postgresql.custom.conf'" >> /var/lib/postgresql/data/pgdata/postgresql.conf
echo "include = 'pg_hba.custom.conf'" >> /var/lib/postgresql/data/pgdata/pg_hba.conf