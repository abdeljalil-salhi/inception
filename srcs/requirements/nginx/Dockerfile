FROM	debian:buster

RUN		apt-get update \
		&& apt-get install -y nginx openssl \
		&& rm -rf /var/lib/apt/lists/* \
		&& mkdir -p /etc/nginx/tls /var/run/nginx \
		&& openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
		-keyout /etc/nginx/tls/absalhi.42.fr.key \
		-out /etc/nginx/tls/absalhi.42.fr.crt \
		-subj "/C=MA/ST=Rehamna/L=Benguerir/O=1337 Future Is Loading/OU=absalhi/CN=absalhi.42.fr" \
		&& ln -sf /dev/stdout /var/log/nginx/access.log \
		&& ln -sf /dev/stderr /var/log/nginx/error.log \
		&& rm -rf /etc/nginx/conf.d/default.conf

COPY	tools/nginx.conf /etc/nginx/conf.d/default.conf
COPY	tools/index.php /var/www/html/index.php

EXPOSE	443

CMD		["nginx", "-g", "daemon off;"]

# RUN	openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
# 		-keyout /etc/ssl/private/absalhi-selfsigned.key \
# 		-out /etc/ssl/certs/absalhi-selfsigned.crt \
# 		-subj "/C=MA/ST=Rehamna/L=Benguerir/O=1337 Future Is Loading/OU=absalhi/CN=absalhi.42.fr"