#!/bin/bash

# Esperar a que mongodb1 esté listo
while ! mongo --tls --tlsCAFile /etc/ssl/ca.crt --tlsCertificateKeyFile /etc/ssl/client/client.pem --host mongodb1 --port 30001 --eval 'db.runCommand({ping: 1})'; do
  echo 'Waiting for mongodb1 to be ready...'
  sleep 5
done;

# Iniciar el replica set
echo 'Initiating replica set...'
mongo --tls --tlsCAFile /etc/ssl/ca.crt --tlsCertificateKeyFile /etc/ssl/client/client.pem --host mongodb1 --port 30001 --eval 'rs.initiate({_id: "rs0", members: [{_id: 0, host: "mongodb1:30001"}, {_id: 1, host: "mongodb2:30002"}, {_id: 2, host: "mongodb3:30003"}]});'

# Esperar a que el replica set esté listo
echo 'Waiting for replica set to initialize...'
sleep 10
while ! mongo --tls --tlsCAFile /etc/ssl/ca.crt --tlsCertificateKeyFile /etc/ssl/client/client.pem --host mongodb1 --port 30001 --eval 'rs.status()'; do
  echo 'Waiting for replica set to initialize...'
  sleep 5
done;

# Crear usuario administrador
echo 'Creating admin user...'
mongo --tls --tlsCAFile /etc/ssl/ca.crt --tlsCertificateKeyFile /etc/ssl/client/client.pem --host mongodb1 --port 30001 --eval 'db.getSiblingDB("admin").createUser({user: "root", pwd: "root", roles: [{role: "root", db: "admin"}]});'
echo 'Admin user created.'

# Habilitar autenticación en todos los nodos
echo 'Enabling authentication...'
docker exec mongodb1 mongod --replSet rs0 --bind_ip_all --port 30001 --tlsMode requireTLS --tlsCertificateKeyFile /etc/ssl/mongodb1/mongodb1.pem --tlsCAFile /etc/ssl/ca.crt --auth &
docker exec mongodb2 mongod --replSet rs0 --bind_ip_all --port 30002 --tlsMode requireTLS --tlsCertificateKeyFile /etc/ssl/mongodb2/mongodb2.pem --tlsCAFile /etc/ssl/ca.crt --auth &
docker exec mongodb3 mongod --replSet rs0 --bind_ip_all --port 30003 --tlsMode requireTLS --tlsCertificateKeyFile /etc/ssl/mongodb3/mongodb3.pem --tlsCAFile /etc/ssl/ca.crt --auth &
echo 'Authentication enabled.'
