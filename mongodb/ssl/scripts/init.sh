#!/bin/bash

# check if replica set is initialized
AUTH_READY=0
while [ $AUTH_READY -eq 0 ]; do
	if [ -f /shared/replica_set_initialized ]; then
		echo "replica set already initialized. starting mongodb with authentication..."
		COMMAND="mongod --replSet rs0 --bind_ip_all --port ${PORT} --tlsMode requireTLS --tlsCertificateKeyFile /etc/ssl/${HOSTNAME}/${HOSTNAME}.pem --tlsCAFile /etc/ssl/ca.crt --auth"
		AUTH_READY=1
	else
		echo "replica set not initialized. starting mongodb without authentication..."
		COMMAND="mongod --replSet rs0 --bind_ip_all --port ${PORT} --tlsMode requireTLS --tlsCertificateKeyFile /etc/ssl/${HOSTNAME}/${HOSTNAME}.pem --tlsCAFile /etc/ssl/ca.crt"
	fi
	echo $COMMAND
	exec $COMMAND
	sleep 10
done