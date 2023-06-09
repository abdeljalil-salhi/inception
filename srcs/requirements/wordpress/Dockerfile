FROM	debian:buster

ARG		DOMAIN_NAME

RUN		apt-get update \
		&& apt-get install -y apt-transport-https lsb-release ca-certificates wget \
		&& wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
		&& echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list \
		&& apt-get update \
		&& apt-get install -y curl mariadb-client \
		php7.4 php7.4-fpm php7.4-mysql php7.4-curl php7.4-json \
		&& rm -rf /var/lib/apt/lists/* \
		&& ln -sf /dev/stdout /var/log/php7.4-fpm.log \
		&& mkdir -p /var/www/wordpress /run/php \
		&& curl -s -o /usr/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
		&& chmod +x /usr/bin/wp \
		&& wp core download --version=6.2.2 --path=/var/www/wordpress --allow-root

COPY	tools/setup.sh /tmp/setup.sh
COPY	assets/favicon.ico /var/www/wordpress/favicon.ico

EXPOSE	9000

CMD		["sh", "/tmp/setup.sh"]