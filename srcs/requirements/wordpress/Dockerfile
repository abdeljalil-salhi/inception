FROM		debian:buster

RUN			apt-get update \
			&& apt-get install -y wget curl bash \
			php php-cgi php-mysql php-fpm php-pdo php-gd php-cli php-mbstring \
			&& rm -rf /var/lib/apt/lists/*

RUN			curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
			&& chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

COPY		tools/www.conf /etc/php/7.3/fpm/pool.d/www.conf

RUN			mkdir /run/php

COPY		tools/setup.sh /tmp/setup.sh
RUN			chmod +x /tmp/setup.sh
ENTRYPOINT	["/tmp/setup.sh"]

WORKDIR		/var/www/html

EXPOSE		9000

CMD			["/usr/sbin/php-fpm7.3", "-F"]