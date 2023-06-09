FROM	debian:buster

RUN		apt-get update \
		&& apt-get install -y curl \
		php7.3 php7.3-fpm php7.3-mysql \
		&& rm -rf /var/lib/apt/lists/* \
		&& ln -sf /dev/stdout /var/log/php7.3-fpm.log \
		&& mkdir -p /var/www/wordpress /run/php

COPY	tools/setup.sh /tmp/setup.sh

EXPOSE	8000

CMD		["sh", "/tmp/setup.sh"]