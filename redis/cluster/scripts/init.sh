#!/bin/sh

REDISDB_CMD="redis-server \
  --appendonly yes \
  --cluster-enabled yes \
  --cluster-config-file nodes.conf \
  --cluster-node-timeout 5000 \
  --cluster-announce-ip $HOSTNAME"

echo "initiating ${HOSTNAME} instance..."
echo $REDISDB_CMD
exec $REDISDB_CMD