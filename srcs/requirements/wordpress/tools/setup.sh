#!/bin/sh
grep -E "listen = /run/php/php7.3-fpm.sock" /etc/php/7.3/fpm/pool.d/www.conf > /dev/null 2>&1
if [ $? -eq 0 ]; then
	sed -i "s|listen = /run/php/php7.3-fpm.sock|listen = 9000|g" /etc/php/7.3/fpm/pool.d/www.conf
	echo "env[MARIADB_HOST] = \$MARIADB_HOST" >> /etc/php/7.3/fpm/pool.d/www.conf
	echo "env[MARIADB_USER] = \$MARIADB_USER" >> /etc/php/7.3/fpm/pool.d/www.conf
	echo "env[MARIADB_PWD] = \$MARIADB_PWD" >> /etc/php/7.3/fpm/pool.d/www.conf
	echo "env[MARIADB_DB] = \$MARIADB_DB" >> /etc/php/7.3/fpm/pool.d/www.conf
fi
if [ -f "/var/www/wordpress/wp-config.php" ]; then
	echo "wordpress already downloaded"
else
	echo "downloading wordpress..."
	sed -i "s/username_here/$MARIADB_USER/g" /var/www/wordpress/wp-config-sample.php
	sed -i "s/password_here/$MARIADB_PWD/g" /var/www/wordpress/wp-config-sample.php
	sed -i "s/localhost/$MARIADB_HOST/g" /var/www/wordpress/wp-config-sample.php
	sed -i "s/database_name_here/$MARIADB_DB/g" /var/www/wordpress/wp-config-sample.php
	cp /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php
	# sleep 5 # wait for mariadb to be ready
	# if [ ! mysqladmin -h $MARIADB_HOST -u $MARIADB_USER --password=$MARIADB_PWD --wait=60 ping > /dev/null ]; then
	# 	echo "mariadb not ready"
	# 	exit 1
	# fi
	echo "installing wordpress..."
	wp core install --url="$DOMAIN_NAME/wordpress" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PWD" --admin_email="$WP_ADMIN_EMAIL" --skip-email --path=/var/www/wordpress --allow-root
	wp plugin update --all --path=/var/www/wordpress --allow-root
	wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PWD --path=/var/www/wordpress --allow-root
fi
php-fpm7.3 -F