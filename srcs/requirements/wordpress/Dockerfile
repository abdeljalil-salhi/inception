FROM	debian:buster

ARG		DOMAIN_NAME

RUN		apt-get update \
		&& apt-get install -y curl mariadb-client \
		php7.3 php7.3-fpm php7.3-mysql php7.3-curl php7.3-json \
		&& rm -rf /var/lib/apt/lists/* \
		&& ln -sf /dev/stdout /var/log/php7.3-fpm.log \
		&& mkdir -p /var/www/wordpress /run/php \
		&& curl -s -o /usr/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
		&& chmod +x /usr/bin/wp \
		&& wp core download --version=6.1.3 --path=/var/www/wordpress --allow-root

COPY	tools/setup.sh /tmp/setup.sh

EXPOSE	9000

CMD		["sh", "/tmp/setup.sh"]