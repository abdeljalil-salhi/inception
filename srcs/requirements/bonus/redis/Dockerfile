FROM	debian:buster

RUN		apt-get update \
		&& apt-get install -y redis-server \
		&& rm -rf /var/lib/apt/lists/* \
		&& ln -sf /dev/stdout /var/log/redis/redis-server.log

COPY	tools/setup.sh /tmp/setup.sh

EXPOSE	6379

CMD		["sh", "/tmp/setup.sh"]