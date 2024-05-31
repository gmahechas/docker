#!/bin/sh

sleep 10

echo "yes" | redis-cli --tls --cacert /etc/ssl/ca.crt --cert /etc/ssl/redisdb1/redisdb1.crt --key /etc/ssl/redisdb1/redisdb1.key --cluster create 172.28.0.2:6379 172.28.0.3:6379 172.28.0.4:6379 --cluster-replicas 0 -a root --user root

exit 0