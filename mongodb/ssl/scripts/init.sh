#!/bin/bash

MONGO_PORT=$1
MONGO_CA_FILE=/etc/ssl/ca.crt
MONGO_CERT_FILE=/etc/ssl/client/client.pem

COMMAND="mongod --replSet rs0 --bind_ip_all --port ${MONGO_PORT} --tlsMode requireTLS --tlsCAFile ${MONGO_CA_FILE} --tlsCertificateKeyFile ${MONGO_CERT_FILE} --auth"

echo $COMMAND
exec $COMMAND

exit 0