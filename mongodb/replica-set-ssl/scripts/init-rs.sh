#!/bin/bash

MONGO_CMD="mongo --tls --tlsCAFile /etc/ssl/ca.crt --tlsCertificateKeyFile /etc/ssl/mongodb1/mongodb1.pem --host mongodb1 --port 30001"

# waiting for mongodb1 to be ready
while ! $MONGO_CMD --eval 'db.runCommand({ping: 1})'; do
  echo 'waiting for mongodb1 to be ready...'
  sleep 5
done;

# initiating replica set
echo 'initiating replica set...'
$MONGO_CMD --eval 'rs.initiate({_id: "rs0", members: [{_id: 0, host: "mongodb1:30001"}, {_id: 1, host: "mongodb2:30002"}, {_id: 2, host: "mongodb3:30003"}]});'

# Waiting for replica set to initialize and a primary node to be elected
echo 'waiting for replica set to initialize...'
PRIMARY_READY=0
while [ $PRIMARY_READY -eq 0 ]; do
  PRIMARY_STATE=$($MONGO_CMD --quiet --eval 'rs.status().members.filter(m => m.stateStr == "PRIMARY").length')
  if [ "$PRIMARY_STATE" -eq 1 ]; then
    echo 'primary node is ready.'
    $MONGO_CMD --eval 'rs.status()'
    PRIMARY_READY=1
  else
    echo 'waiting for a primary node to be elected...'
    sleep 5
  fi
done

exit 0