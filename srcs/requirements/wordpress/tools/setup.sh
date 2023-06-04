#!/bin/sh

while ! mariadb -h$MARIADB_HOSTNAME -u$MARIADB_USERNAME -p$MARIADB_PASSWORD $MARIADB_DATABASE &>/dev/null; do
    sleep 3
done

if [ ! -f "/var/www/html/index.html" ]; then

    mv /tmp/index.html /var/www/html/index.html

    wp core download --allow-root
    wp config create --dbname=$MARIADB_DATABASE --dbuser=$MARIADB_USERNAME --dbpass=$MARIADB_PASSWORD --dbhost=$MARIADB_HOSTNAME --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
    wp core install --url=$DOMAIN_NAME/wordpress --title=$WP_TITLE --admin_user=$WP_ADMIN_USERNAME --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
    wp user create $WP_USERNAME $WP_EMAIL --role=author --user_pass=$WP_PASSWORD --allow-root
    wp theme install inspiro --activate --allow-root
    wp plugin update --all --allow-root

fi


echo "wordpress listening on port 9000"
/usr/sbin/php-fpm7 -F -R
