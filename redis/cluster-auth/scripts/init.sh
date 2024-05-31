#!/bin/sh

REDISDB_ANNOUNCE_IP=$1

redis-server \
  --cluster-enabled yes \
  --cluster-config-file nodes.conf \
  --cluster-node-timeout 5000 \
  --appendonly yes \
  --requirepass root \
  --masterauth root \
  --aclfile /etc/config/acl.conf \
  --cluster-announce-ip $REDISDB_ANNOUNCE_IP