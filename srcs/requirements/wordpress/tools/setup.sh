#!/bin/sh
if [ -f ./wp-config.php ]
then
	echo "wordpress already downloaded"
else
	echo "downloading wordpress..."
	wp core download --allow-root
	sed -i "s/username_here/$MARIADB_USERNAME/g" wp-config-sample.php
	sed -i "s/password_here/$MARIADB_PASSWORD/g" wp-config-sample.php
	sed -i "s/localhost/$MARIADB_HOSTNAME/g" wp-config-sample.php
	sed -i "s/database_name_here/$MARIADB_DATABASE/g" wp-config-sample.php
	cp wp-config-sample.php wp-config.php
	wp core install --allow-root --url=$DOMAIN_NAME/wordpress --title=$WP_TITLE --admin_user=$WP_ADMIN_USERNAME --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email
	wp user create --allow-root $WP_USERNAME $WP_EMAIL --user_pass=$WP_PASSWORD --role=author
	wp theme install --allow-root inspiro --activate
fi
echo "wordpress listening on port 9000"
exec "$@"