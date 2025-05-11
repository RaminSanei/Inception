#!/bin/bash

wp_url = https://ssanei.42.fr;

cd /var/www/html

if [ ! -f /var/www/html/wp-config.php ]; then
    wp core download --allow-root
    wp plugin install woocommerce jetpack contact-form-7 --activate --allow-root
    wp theme install astra oceanwp --activate --allow-root
    
fi

sleep 10

wp config create \
    --url="$DOMAIN_NAME" \
    --dbname="$DB_NAME" \
    --dbuser="$DB_USER" \
    --dbpass="$DB_PASSWORD" \
    --dbhost="mariadb" \
    --allow-root

wp core install \
    --url="$DOMAIN_NAME" \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="$WP_ADMIN_EMAIL" \
    --allow-root

wp user create "$WP_USER" "$WP_USER_EMAIL" \
    --user_pass="$WP_USER_PASSWORD" \
    --role=author \
    --allow-root


wp option update home "$wp_url" --allow-root --quiet
wp option update siteurl "$wp_url" --allow-root --quiet

find wp-content/uploads -type d -exec chmod 755 {} \;   # Directories: 755
find wp-content/uploads -type f -exec chmod 644 {} \;   # Files: 644
chown -R www-data:www-data wp-content/uploads

php-fpm7.3 -F
