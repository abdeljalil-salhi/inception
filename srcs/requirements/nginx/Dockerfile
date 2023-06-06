FROM	debian:buster

RUN		apt-get update \
		&& apt-get install -y nginx openssl \
		&& rm -rf /var/lib/apt/lists/* \
		&& ln -sf /dev/stdout /var/log/nginx/access.log \
		&& ln -sf /dev/stderr /var/log/nginx/error.log \
		&& rm -rf /etc/nginx.conf.d/default.conf \
		&& rm -rf /var/www/html/* && mkdir -p /etc/nginx/tls \
		&& openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
		-keyout /etc/nginx/tls/absalhi.42.fr.key -out /etc/nginx/tls/absalhi.42.fr.crt \
		-subj "/C=MA/ST=Rehamna/L=Benguerir/O=1337 Future Is Loading/OU=absalhi/CN=absalhi.42.fr"

COPY	tools/nginx.conf /etc/nginx/conf.d/default.conf
COPY	tools/index.html /var/www/html/index.html
COPY	tools/favicon.ico /var/www/html/favicon.ico

EXPOSE	443

CMD		["nginx", "-g", "daemon off;"]