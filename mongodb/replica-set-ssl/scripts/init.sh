#!/bin/bash

MONGODB_CERTIFICATE_KEY_FILE=$1
MONGODB_INIT_FLAG=/etc/config/.mongodb_init_flag
MONGODB_CMD="mongod --replSet rs0 --bind_ip_all --tlsMode requireTLS --tlsCAFile /etc/ssl/ca.crt --tlsCertificateKeyFile ${MONGODB_CERTIFICATE_KEY_FILE}"

if [ -s "$MONGODB_INIT_FLAG" ]; then
	MONGODB_CMD="$MONGODB_CMD --keyFile /etc/config/mongodb-keyfile"
fi

echo "initiating ${HOSTNAME} instance..."
echo $MONGODB_CMD
exec $MONGODB_CMD