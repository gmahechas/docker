#!/bin/bash

# Esperar a que mongodb1 esté listo
while ! mongo --tls --tlsCAFile /etc/ssl/ca.crt --tlsCertificateKeyFile /etc/ssl/client/client.pem --host mongodb1 --port 30001 --eval 'db.runCommand({ping: 1})'; do
  echo 'Waiting for mongodb1 to be ready...'
  sleep 5
done;

# Iniciar el replica set
echo 'Initiating replica set...'
mongo --tls --tlsCAFile /etc/ssl/ca.crt --tlsCertificateKeyFile /etc/ssl/client/client.pem --host mongodb1 --port 30001 --eval 'rs.initiate({_id: "rs0", members: [{_id: 0, host: "mongodb1:30001"}, {_id: 1, host: "mongodb2:30002"}, {_id: 2, host: "mongodb3:30003"}]});'

# Esperar a que el replica set esté listo y un nodo sea elegido como PRIMARY
echo 'Waiting for replica set to initialize...'
PRIMARY_READY=0
while [ $PRIMARY_READY -eq 0 ]; do
  PRIMARY_STATE=$(mongo --tls --tlsCAFile /etc/ssl/ca.crt --tlsCertificateKeyFile /etc/ssl/client/client.pem --host mongodb1 --port 30001 --quiet --eval 'rs.status().members.filter(m => m.stateStr == "PRIMARY").length')
  if [ "$PRIMARY_STATE" -eq 1 ]; then
    PRIMARY_READY=1
    echo 'Primary node is ready.'
  else
    echo 'Waiting for a primary node to be elected...'
    sleep 5
  fi
done

# Crear usuario administrador
echo 'Creating admin user...'
mongo --tls --tlsCAFile /etc/ssl/ca.crt --tlsCertificateKeyFile /etc/ssl/client/client.pem --host mongodb1 --port 30001 --eval 'db.getSiblingDB("admin").createUser({user: "root", pwd: "root", roles: [{role: "root", db: "admin"}]});'
echo 'Admin user created.'

# Habilitar autenticación en todos los nodos
echo 'Enabling authentication...'
for NODE in mongodb1 mongodb2 mongodb3; do
  mongod --replSet rs0 --bind_ip_all --port 30001 --tlsMode requireTLS --tlsCertificateKeyFile /etc/ssl/$NODE/$NODE.pem --tlsCAFile /etc/ssl/ca.crt --auth &
done
echo 'Authentication enabled.'
