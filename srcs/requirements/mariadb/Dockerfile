FROM		alpine:3.17

RUN			apk update && apk upgrade \
			&& apk add --no-cache mariadb mariadb-client

COPY		tools/setup.sh /tmp/setup.sh
COPY		conf/mariadb.conf /etc/my.cnf.d/mariadb-server.cnf

EXPOSE		3306

ENTRYPOINT	[ "sh", "/tmp/setup.sh" ]