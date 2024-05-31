#!/bin/sh

REDISDB_ANNOUNCE_IP=$1
REDISDB_NODE=$2

REDISDB_CMD="redis-server \
  --appendonly yes \
  --requirepass root \
  --masterauth root \
  --aclfile /etc/config/acl.conf \
  --port 0 \
  --cluster-enabled yes \
  --cluster-config-file nodes.conf \
  --cluster-node-timeout 5000 \
  --cluster-announce-ip $REDISDB_ANNOUNCE_IP \
  --tls-port 6380 \
  --tls-cert-file /etc/ssl/$REDISDB_NODE/$REDISDB_NODE.crt \
  --tls-key-file /etc/ssl/$REDISDB_NODE/$REDISDB_NODE.key \
  --tls-ca-cert-file /etc/ssl/ca.crt \
  --tls-auth-clients yes \
  --loglevel debug"

echo "initiating ${HOSTNAME} instance..."
echo $REDISDB_CMD
exec $REDISDB_CMD
