#!/bin/bash

MONGO_INIT_FLAG=/etc/config/.mongodb_init_flag
MONGODB_CMD="mongod --replSet rs0 --bind_ip_all"

if [ -s "$MONGO_INIT_FLAG" ]; then
	MONGODB_CMD="$MONGODB_CMD --keyFile /etc/config/mongodb-keyfile"
fi

echo "initiating ${HOSTNAME} instance..."
echo $MONGODB_CMD
exec $MONGODB_CMD