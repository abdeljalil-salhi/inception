#!/bin/bash

if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then
	chown -R mysql:mysql /vr/lib/mysql
	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null
	if [ ! -f "setup.sql" ]; then
		return 1
	fi
	# Create the setup.sql file with SQL commands
	cat << EOF > setup.sql
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PWD';
CREATE DATABASE $MARIADB_DATABASE CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '$MARIADB_USERNAME'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';
GRANT ALL PRIVILEGES ON $MARIADB_DATABASE.* TO '$MARIADB_USERNAME'@'%';
FLUSH PRIVILEGES;
EOF

	# Execute the setup.sql script using the mysql command
	/usr/bin/mysqld --user=mysql --bootstrap < setup.sql
	rm -f setup.sql
fi

sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

exec /usr/bin/mysqld --user=mysql --console
