#!/bin/bash

MONGODB_PORT=$1
MONGODB_INIT_FLAG=/etc/config/.mongodb_init_flag
MONGODB_CMD="mongod --replSet rs0 --bind_ip_all --tlsMode requireTLS --tlsCAFile /etc/ssl/ca.crt --tlsCertificateKeyFile /etc/ssl/mongodb/mongodb.pem --port $MONGODB_PORT"

if [ -s "$MONGODB_INIT_FLAG" ]; then
	MONGODB_CMD="$MONGODB_CMD --keyFile /etc/config/mongodb-keyfile"
fi

echo "initiating ${HOSTNAME} instance..."
echo $MONGODB_CMD
exec $MONGODB_CMD