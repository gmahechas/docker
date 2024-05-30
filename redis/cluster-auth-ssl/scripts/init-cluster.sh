#!/bin/sh

sleep 10
echo "yes" | redis-cli --tls --cacert /etc/ssl/ca.crt --cert /etc/ssl/redis1/redis1.crt --key /etc/ssl/redis1/redis1.key --cluster create 172.28.0.2:6380 172.28.0.3:6380 172.28.0.4:6380 --cluster-replicas 0 -a root --user root

exit 0