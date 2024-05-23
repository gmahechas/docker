#!/bin/bash

# check if replica set is initialized
if [ -f /data/db/replica_set_initialized ]; then
  echo "replica set already initialized. starting mongodb with authentication..."
  exec mongod --replSet rs0 --bind_ip_all --port "${PORT}" --tlsMode requireTLS --tlsCertificateKeyFile "/etc/ssl/${HOSTNAME}/${HOSTNAME}.pem" --tlsCAFile "/etc/ssl/ca.crt" --auth
else
  echo "replica set not initialized. starting mongodb without authentication..."
  exec mongod --replSet rs0 --bind_ip_all --port "${PORT}" --tlsMode requireTLS --tlsCertificateKeyFile "/etc/ssl/${HOSTNAME}/${HOSTNAME}.pem" --tlsCAFile "/etc/ssl/ca.crt"
fi
