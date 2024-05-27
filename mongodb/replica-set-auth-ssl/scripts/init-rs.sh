#!/bin/bash

MONGODB_INIT_FLAG=/etc/config/.mongodb_init_flag
MONGODB_CMD="mongo --host mongodb1.gmahechas.local --tls --tlsCAFile /etc/ssl/ca.crt --tlsCertificateKeyFile /etc/ssl/mongodb1/mongodb1.pem"

if [ -s "$MONGODB_INIT_FLAG" ]; then
	echo "replica set already initialized"
	exit 0
fi

# waiting for mongodb1.gmahechas.local to be ready
while ! $MONGODB_CMD --eval 'db.runCommand({ping: 1})'; do
  echo 'waiting for mongodb1.gmahechas.local to be ready...'
  sleep 5
done;

# initiating replica set
echo 'initiating replica set...'
$MONGODB_CMD --eval 'rs.initiate({_id: "rs0", members: [{_id: 0, host: "mongodb1.gmahechas.local"}, {_id: 1, host: "mongodb2.gmahechas.local"}, {_id: 2, host: "mongodb3.gmahechas.local"}]});'

# Waiting for replica set to initialize and a primary node to be elected
echo 'waiting for replica set to initialize...'
PRIMARY_READY=0
while [ $PRIMARY_READY -eq 0 ]; do
  PRIMARY_STATE=$($MONGODB_CMD --quiet --eval 'rs.status().members.filter(m => m.stateStr == "PRIMARY").length')
  if [ "$PRIMARY_STATE" -eq 1 ]; then
    echo 'primary node is ready.'
    PRIMARY_READY=1
  else
    echo 'waiting for a primary node to be elected...'
    sleep 5
  fi
done

echo 'creating root user...'
$MONGODB_CMD --eval 'db.getSiblingDB("admin").createUser({user: "root", pwd: "root", roles: [{role: "root", db: "admin"}]});'
echo 'root user created.'

echo 'creating replica set init flag...'
echo "1" > $MONGODB_INIT_FLAG

exit 0