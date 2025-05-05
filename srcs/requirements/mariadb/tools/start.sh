# #!/bin/bash

# GREEN='\033[0;32m'
# NC='\033[0m'

# sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf 

# # Start the MySQL service
# service mysql start

# # Wait for MySQL to be fully up and running
# until mysqladmin ping &>/dev/null; do
#   echo -e "${GREEN}Waiting for MySQL to be up...${NC}"
#   sleep 2
# done

# mysql -u root <<EOF
# CREATE DATABASE IF NOT EXISTS ${DB_NAME};
# CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
# GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
# ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
# FLUSH PRIVILEGES;
# EOF
# # Stop the service to allow the connection from any IP address from the network
# kill $(cat /run/mysqld/mysqld.pid)

# mysqld_safe

#!/bin/bash

#!/bin/bash

set -e

# Ensure MySQL runtime directory exists and is owned properly
chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

# Initialize database if not yet done
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --ldata=/var/lib/mysql
fi

# Start MariaDB in safe mode and run setup
mysqld_safe --datadir=/var/lib/mysql &

# Wait until MariaDB is ready
until mysqladmin ping --silent; do
    echo "Waiting for MariaDB to be ready..."
    sleep 2
done

# Execute initial setup
mysql -u root <<-EOSQL
    CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
    CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
    FLUSH PRIVILEGES;
EOSQL

# Shutdown safe mode to relaunch normally
mysqladmin shutdown

# Start MariaDB normally
exec mysqld_safe --datadir=/var/lib/mysql
