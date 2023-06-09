#!/bin/sh
echo "Starting php-fpm..."
grep -E "listen = /run/php/php7.3-fpm.sock" /etc/php/7.3/fpm/pool.d/www.conf > /dev/null 2>&1
if [ $? -eq 0 ]; then
	sed -i "s|listen = /run/php/php7.3-fpm.sock|listen = 8000|g" /etc/php/7.3/fpm/pool.d/www.conf
fi
if [ -f "/var/www/wordpress/adminer.index.php" ]; then
	echo "Adminer already downloaded"
else
	echo "Installing adminer..."
	mkdir -p /var/www/wordpress/adminer
	curl -s -L https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql-en.php --output /var/www/wordpress/adminer/index.php
fi
echo "Adminer is listening on port 8000"
php-fpm7.3 -F