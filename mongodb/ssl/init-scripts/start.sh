#!/bin/bash

export PORT=${PORT}
export HOSTNAME=${HOSTNAME}#

# check if replica set is initialized
if [ -f /data/db/replica_set_initialized ]; then
  echo "replica set already initialized. starting mongodb with authentication..."
  COMMAND="mongod --replSet rs0 --bind_ip_all --port ${PORT} --tlsMode requireTLS --tlsCertificateKeyFile /etc/ssl/${HOSTNAME}/${HOSTNAME}.pem --tlsCAFile /etc/ssl/ca.crt --auth"
  echo $COMMAND
  exec $COMMAND
else
  echo "replica set not initialized. starting mongodb without authentication..."
  COMMAND="mongod --replSet rs0 --bind_ip_all --port ${PORT} --tlsMode requireTLS --tlsCertificateKeyFile /etc/ssl/${HOSTNAME}/${HOSTNAME}.pem --tlsCAFile /etc/ssl/ca.crt"
  echo $COMMAND
  exec $COMMAND
fi
