# #!/bin/bash

# wp_url = https://ssanei.42.fr;

# cd /var/www/html

# if [ ! -f /var/www/html/wp-config.php ]; then
#     wp core download --allow-root
    
# fi

# sleep 10

# wp config create --url="$DOMAIN_NAME" --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASSWORD" --dbhost="mariadb" --allow-root

# wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root

# wp user create $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD --role=author --allow-root


# # wp option update home "https://ssanei.42.fr" --allow-root
# # wp option update siteurl "https://ssanei.42.fr" --allow-root

# # chmod -R 755 wp-content/uploads
# # chown -R www-data:www-data wp-content/uploads

# wp option update home "$wp_url" --allow-root --quiet
# wp option update siteurl "$wp_url" --allow-root --quiet

# find wp-content/uploads -type d -exec chmod 755 {} \;   # Directories: 755
# find wp-content/uploads -type f -exec chmod 644 {} \;   # Files: 644
# chown -R www-data:www-data wp-content/uploads


# php-fpm7.3 -F

WP_URL="https://ssanei.42.fr"
WEB_ROOT="/var/www/html"

cd "$WEB_ROOT"

# Download WordPress core only if not already present
if [ ! -f wp-config.php ]; then
    wp core download --allow-root
fi

# Wait for DB container to be ready (can be replaced with a proper health check)
sleep 10

# Create wp-config.php with environment variables
wp config create \
    --url="$DOMAIN_NAME" \
    --dbname="$DB_NAME" \
    --dbuser="$DB_USER" \
    --dbpass="$DB_PASSWORD" \
    --dbhost="mariadb" \
    --allow-root

# Install WordPress core
wp core install \
    --url="$DOMAIN_NAME" \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="$WP_ADMIN_EMAIL" \
    --allow-root

# Create additional author user
wp user create "$WP_USER" "$WP_USER_EMAIL" \
    --user_pass="$WP_USER_PASSWORD" \
    --role=author \
    --allow-root

# Update home and site URL
wp option update home "$WP_URL" --allow-root --quiet
wp option update siteurl "$WP_URL" --allow-root --quiet

# Set secure file/directory permissions for uploads
UPLOADS_DIR="wp-content/uploads"
if [ -d "$UPLOADS_DIR" ]; then
    find "$UPLOADS_DIR" -type d -exec chmod 755 {} \;
    find "$UPLOADS_DIR" -type f -exec chmod 644 {} \;
    chown -R www-data:www-data "$UPLOADS_DIR"
fi

# Start PHP-FPM
exec php-fpm7.3 -F
