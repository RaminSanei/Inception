#!/bin/bash

cd /var/www/html

if [ ! -f /var/www/html/wp-config.php ]; then
    wp core download --allow-root
fi


# cp wp-config-sample.php wp-config.php

# sed -i -r "s/database_name_here/$DB_NAME/" wp-config.php
# sed -i -r "s/username_here/$DB_USER/" wp-config.php
# sed -i -r "s/password_here/$DB_PASSWORD/" wp-config.php
# sed -i -r "s/localhost/mariadb/" wp-config.php

# sed -i 's|listen = /run/php/php7.3-fpm.sock|listen = 9000|g' /etc/php/7.3/fpm/pool.d/www.conf

sleep 10
wp config create --url="$DOMAIN_NAME" --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASSWORD" --dbhost="$DB_HOST" --allow-root

wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root

wp user create $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD --role=author --allow-root


wp option update home "https://ssanei.42.fr" --allow-root
wp option update siteurl "https://ssanei.42.fr" --allow-root

chmod -R 755 wp-content/uploads
chown -R www-data:www-data wp-content/uploads

php-fpm7.3 -F
