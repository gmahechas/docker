#!/bin/sh

REDISDB_ANNOUNCE_IP=$1

REDISDB_CMD="redis-server \
  --appendonly yes \
  --cluster-enabled yes \
  --cluster-config-file nodes.conf \
  --cluster-node-timeout 5000 \
  --cluster-announce-ip $REDISDB_ANNOUNCE_IP"

echo "initiating ${HOSTNAME} instance..."
echo $REDISDB_CMD
exec $REDISDB_CMD