#!/bin/sh

sleep 10

REDISDB_INFO=$(redis-cli -a root --user root -p 6380 -h redisdb1.gmahechas.local --tls --cacert /etc/ssl/ca.crt --cert /etc/ssl/redisdb/redisdb.crt --key /etc/ssl/redisdb/redisdb.key cluster info)

if echo "$REDISDB_INFO" | grep -q "cluster_state:ok"; then
  echo "cluster already initialized"
  exit 0
fi

# initiating cluster
echo "yes" | redis-cli -a root --user root -p 6380 -h redisdb1.gmahechas.local --tls --cacert /etc/ssl/ca.crt --cert /etc/ssl/redisdb/redisdb.crt --key /etc/ssl/redisdb/redisdb.key --cluster create 172.28.0.2:6380 172.28.0.3:6480 172.28.0.4:6580 --cluster-replicas 0

exit 0