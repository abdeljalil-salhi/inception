FROM	debian:buster

RUN		apt-get update \
		&& apt-get install -y nginx \
		&& rm -rf /var/lib/apt/lists/* \
		&& ln -sf /dev/stdout /var/log/nginx/access.log \
		&& ln -sf /dev/stderr /var/log/nginx/error.log \
		&& rm -rf /etc/nginx.conf.d/default.conf \
		&& rm -rf /var/www/html/*

COPY	tools/nginx.conf /etc/nginx/conf.d/default.conf
COPY	tools/index.html /var/www/html/index.html
COPY	tools/favicon.ico /var/www/html/favicon.ico

EXPOSE	80

CMD		["nginx", "-g", "daemon off;"]