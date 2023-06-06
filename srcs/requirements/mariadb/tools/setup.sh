#!/bin/sh
service mysql start
mariadb -u root -e "CREATE DATABASE IF NOT EXISTS \`${MARIADB_DB}\`;"
mariadb -u root -e "CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PWD}';"
mariadb -u root -e "GRANT ALL PRIVILEGES ON \`${MARIADB_DB}\`.* TO '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PWD}';"
mariadb -u root -e "ALTER USER 'root'@'%' IDENTIFIED BY '${MARIADB_ROOT_PWD}';"
mariadb -u root -e "FLUSH PRIVILEGES;"