#!/bin/sh

REDIS_ANNOUNCE_IP=$1
REDIS_NODE=$2

redis-server \
  --cluster-enabled yes \
  --cluster-config-file nodes.conf \
  --cluster-node-timeout 5000 \
  --appendonly yes \
  --requirepass root \
  --masterauth root \
  --aclfile /etc/config/acl.conf \
  --cluster-announce-ip $REDIS_ANNOUNCE_IP \
  --port 0 \
  --tls-port 6380 \
  --tls-cert-file /etc/ssl/$REDIS_NODE/$REDIS_NODE.crt \
  --tls-key-file /etc/ssl/$REDIS_NODE/$REDIS_NODE.key \
  --tls-ca-cert-file /etc/ssl/ca.crt \
  --tls-auth-clients yes
