#!/bin/bash

MONGO_HOST=$1
MONGO_PORT=$2
MONGO_CA_FILE=/etc/ssl/ca.crt
MONGO_CERT_FILE=/etc/ssl/client/client.pem

STATUS=$(echo 'rs.status().members.find(m => m.name === "'$MONGO_HOST':'$MONGO_PORT'" && (m.stateStr === "PRIMARY" || m.stateStr === "SECONDARY")) ? 1 : 0' | mongo --tls --tlsCAFile $MONGO_CA_FILE --tlsCertificateKeyFile $MONGO_CERT_FILE --host $MONGO_HOST --port $MONGO_PORT --quiet)
#STATUS=$(echo 'rs.status().members.find(m => m.name === "'$MONGO_HOST':'$MONGO_PORT'" && (m.stateStr === "PRIMARY" || m.stateStr === "SECONDARY")) ? 1 : 0' | mongo --tls --tlsCAFile $MONGO_CA_FILE --tlsCertificateKeyFile $MONGO_CERT_FILE --host $MONGO_HOST --port $MONGO_PORT -u root -p root --authenticationDatabase admin --quiet)

if [ "$STATUS" -eq 1 ]; then
  exit 0
else
  exit 1
fi
