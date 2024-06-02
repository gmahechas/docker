#!/bin/sh

sleep 10

echo "yes" | redis-cli -a root --user root -p 6379 -h redisdb1.gmahechas.local --cluster create 172.28.0.2:6379 172.28.0.3:6379 172.28.0.4:6379 --cluster-replicas 0 -a root --user root

exit 0