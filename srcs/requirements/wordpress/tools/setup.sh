#!/bin/sh
grep -E "listen = /run/php/php7.3-fpm.sock" /etc/php/7.3/fpm/pool.d/www.conf > /dev/null 2>&1
if [ $? -eq 0 ]; then
	sed -i "s|listen = /run/php/php7.3-fpm.sock|listen = 9000|g" /etc/php/7.3/fpm/pool.d/www.conf
fi
if [ -f "/var/www/wordpress/wp-config.php" ]; then
	echo "Wordpress already downloaded"
else
	echo "Downloading wordpress..."
	sed -i "s/username_here/$MARIADB_USER/g" /var/www/wordpress/wp-config-sample.php
	sed -i "s/password_here/$MARIADB_PWD/g" /var/www/wordpress/wp-config-sample.php
	sed -i "s/localhost/$MARIADB_HOST/g" /var/www/wordpress/wp-config-sample.php
	sed -i "s/database_name_here/$MARIADB_DB/g" /var/www/wordpress/wp-config-sample.php
	sed -i "40i define('WP_REDIS_HOST', '$WP_REDIS_HOST');" /var/www/wordpress/wp-config-sample.php
	sed -i "41i define('WP_REDIS_PORT', '$WP_REDIS_PORT');" /var/www/wordpress/wp-config-sample.php
	sed -i "42i define('WP_REDIS_TIMEOUT', '$WP_REDIS_TIMEOUT');" /var/www/wordpress/wp-config-sample.php
	sed -i "43i define('WP_REDIS_READ_TIMEOUT', '$WP_REDIS_READ_TIMEOUT');" /var/www/wordpress/wp-config-sample.php
	sed -i "44i define('WP_REDIS_DATABASE', '$WP_REDIS_DATABASE');" /var/www/wordpress/wp-config-sample.php
	cp /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php
	echo "Installing wordpress..."
	wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PWD" --admin_email="$WP_ADMIN_EMAIL" --skip-email --path=/var/www/wordpress --allow-root
	wp plugin install redis-cache --activate --path=/var/www/wordpress --allow-root
	wp redis enable --path=/var/www/wordpress --allow-root
	wp plugin update --all --path=/var/www/wordpress --allow-root
	wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PWD --path=/var/www/wordpress --allow-root
	wp theme install twentytwenty --activate --path=/var/www/wordpress --allow-root
fi
php-fpm7.3 -F