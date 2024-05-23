#!/bin/bash

# check if replica set is initialized
if [ -f /data/db/replica_set_initialized ]; then
  echo "Replica set already initialized. Starting MongoDB with authentication..."
  exec mongod --replSet rs0 --bind_ip_all --port $PORT --tlsMode requireTLS --tlsCertificateKeyFile /etc/ssl/$HOSTNAME/$HOSTNAME.pem --tlsCAFile /etc/ssl/ca.crt --auth
else
  echo "Replica set not initialized. Starting MongoDB without authentication..."
  exec mongod --replSet rs0 --bind_ip_all --port $PORT --tlsMode requireTLS --tlsCertificateKeyFile /etc/ssl/$HOSTNAME/$HOSTNAME.pem --tlsCAFile /etc/ssl/ca.crt
fi
