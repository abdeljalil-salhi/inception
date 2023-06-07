#!/bin/sh
grep -E "bind 127.0.0.1 ::1" /etc/redis/redis.conf > /dev/null 2>&1
if [ $? -eq 0 ]; then
	sed -i "s/bind 127.0.0.1 ::1/bind 0.0.0.0/g" /etc/redis/redis.conf
fi
grep -E "protected-mode yes" /etc/redis/redis.conf > /dev/null 2>&1
if [ $? -eq 0 ]; then
	sed -i "s/protected-mode yes/protected-mode no/g" /etc/redis/redis.conf
fi
redis-server /etc/redis/redis.conf --daemonize no