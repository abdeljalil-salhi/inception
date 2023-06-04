FROM	debian:buster

RUN		apt-get update \
		&& apt-get install -y nginx openssl \
		&& rm -rf /var/lib/apt/lists/*

COPY	tools/nginx.conf /etc/nginx/conf.d/nginx.conf
COPY	tools/index.php /var/www/html/index.php
RUN		mkdir -p /run/nginx

RUN		openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
			-keyout /etc/ssl/private/absalhi-selfsigned.key \
			-out /etc/ssl/certs/absalhi-selfsigned.crt \
			-subj "/C=MA/ST=Rehamna/L=Benguerir/O=1337 Future Is Loading/OU=absalhi/CN=absalhi.42.fr"

EXPOSE	443

CMD		["nginx", "-g", "daemon off;"]