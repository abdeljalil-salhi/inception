FROM		debian:buster

RUN			apt-get update \
			&& apt install -y mariadb-server \
			&& rm -rf /var/lib/apt/lists/*

ARG			MARIADB_DB
ARG			MARIADB_USER
ARG			MARIADB_PWD
ARG			MARIADB_ROOT_PWD

COPY		tools/setup.sh /tmp/setup.sh

RUN			chmod +x /tmp/setup.sh \
			&& /tmp/setup.sh \
			&& rm -rf /tmp/setup.sh

EXPOSE		3306

ENTRYPOINT	[ "mysqld", "--bind-address=0.0.0.0" ]