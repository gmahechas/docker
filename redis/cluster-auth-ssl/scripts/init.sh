#!/bin/sh
REDISDB_PORT=$1
REDISDB_CMD="
  redis-server \
  --bind 0.0.0.0 \
  --appendonly yes \
  --requirepass root \
  --masterauth root \
  --aclfile /etc/config/acl.conf \
  --cluster-enabled yes \
  --cluster-config-file nodes.conf \
  --cluster-node-timeout 5000 \
  --cluster-announce-ip $HOSTNAME \
  --port 0 \
  --tls-cluster yes \
  --tls-port $REDISDB_PORT \
  --tls-cert-file /etc/ssl/redisdb/redisdb.crt \
  --tls-key-file /etc/ssl/redisdb/redisdb.key \
  --tls-ca-cert-file /etc/ssl/ca.crt \
  --tls-auth-clients yes \
  --loglevel notice"

echo "initiating ${HOSTNAME} instance..."
echo $REDISDB_CMD
exec $REDISDB_CMD
