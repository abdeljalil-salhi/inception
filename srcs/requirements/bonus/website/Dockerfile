FROM	alpine:3.13 as builder

COPY	app /app

WORKDIR	/app
RUN		apk update \
		&& apk add nodejs npm \
		&& npm install \
		&& npm run build \
		&& rm -rf node_modules \
		&& apk del nodejs npm

# ---------------------------------------------------- #

FROM	alpine:3.13 as runner

RUN		apk update \
		&& apk add nginx \
		&& mkdir -p /var/run/nginx /etc/nginx/conf.d \
		&& rm -rf /etc/nginx/conf.d/default.conf \
		&& rm -rf /var/cache/apk/* /var/www/html/*

COPY	--from=builder /app/build /var/www/html
COPY	conf/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE	4000

CMD		[ "nginx", "-g", "daemon off;" ]