FROM	debian:buster

ARG		LOGIN
ARG		DOMAIN_NAME

RUN		apt-get update \
		&& apt-get install -y nginx openssl gettext-base \
		&& rm -rf /var/lib/apt/lists/* \
		&& ln -sf /dev/stdout /var/log/nginx/access.log \
		&& ln -sf /dev/stderr /var/log/nginx/error.log \
		&& rm -rf /etc/nginx.conf.d/default.conf /var/www/html/* \
		&& mkdir -p /etc/nginx/tls /etc/www/wordpress /var/cache/nginx \
		&& openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
		-keyout "/etc/nginx/tls/${DOMAIN_NAME}.key" -out "/etc/nginx/tls/${DOMAIN_NAME}.crt" \
		-subj "/C=MA/ST=Rehamna/L=Benguerir/O=1337 Future Is Loading/OU=${LOGIN}/CN=${DOMAIN_NAME}"

COPY	tools/nginx.conf /tmp/nginx.conf.template
RUN		export DOMAIN_NAME=${DOMAIN_NAME} \
		&& envsubst '$DOMAIN_NAME' < /tmp/nginx.conf.template > /etc/nginx/conf.d/default.conf \
		&& rm -rf /tmp/nginx.conf.template

COPY	tools/index.html /var/www/html/index.html
COPY	tools/favicon.ico /var/www/html/favicon.ico

EXPOSE	443

CMD		["nginx", "-g", "daemon off;"]