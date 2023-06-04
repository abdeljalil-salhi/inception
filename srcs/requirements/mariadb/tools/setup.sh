#!/bin/bash
if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then
	chown -R mysql:mysql /var/lib/mysql
	# mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null
	echo "START mysql_install_db"
	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm
	echo "END mysql_install_db"
	if [ ! -f "setup.sql" ]; then
		return 1
	fi
	cat << EOF > setup.sql
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PWD';
CREATE DATABASE IF NOT EXISTS $MARIADB_DATABASE CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '$MARIADB_USERNAME'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO '$MARIADB_USERNAME'@'%' IDENTIFIED BY '$MARIADB_PASSWORD' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF
	/usr/bin/mysqld_safe --user=mysql --bootstrap < setup.sql
	rm -f setup.sql
fi

echo "user: $MARIADB_USERNAME"
echo "password: $MARIADB_PASSWORD"
echo "database: $MARIADB_DATABASE"
echo "root password: $MARIADB_ROOT_PWD"
echo "hostname: $MARIADB_HOSTNAME"
echo "mariadb listening on port 3306"

sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

exec /usr/bin/mysqld --user=mysql --console

# USE mysql;
# FLUSH PRIVILEGES;
# DELETE FROM mysql.user WHERE User='';
# DROP DATABASE test;
# DELETE FROM mysql.db WHERE Db='test';
# DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');