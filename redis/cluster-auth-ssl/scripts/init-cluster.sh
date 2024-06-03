#!/bin/sh

sleep 10

echo "yes" | redis-cli -a root --user root -p 6379 -h redisdb1.gmahechas.local --tls --cacert /etc/ssl/ca.crt --cert /etc/ssl/redisdb/redisdb.crt --key /etc/ssl/redisdb/redisdb.key --cluster create 172.28.0.2:6379 172.28.0.3:6379 172.28.0.4:6379 --cluster-replicas 0

exit 0