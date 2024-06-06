#!/bin/sh

REDISDB_ANNOUNCE_IP=$1

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
  --cluster-announce-ip $REDISDB_ANNOUNCE_IP \
  --port 0 \
  --tls-cluster yes \
  --tls-port 6380 \
  --tls-cert-file /etc/ssl/redisdb/redisdb.crt \
  --tls-key-file /etc/ssl/redisdb/redisdb.key \
  --tls-ca-cert-file /etc/ssl/ca.crt \
  --tls-auth-clients yes" #--loglevel debug"

echo "initiating ${HOSTNAME} instance..."
echo $REDISDB_CMD
exec $REDISDB_CMD
