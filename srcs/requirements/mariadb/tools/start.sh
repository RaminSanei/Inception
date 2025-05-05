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

MYSQL_DATA_DIR="/var/lib/mysql"
MYSQL_DB_DIR="$MYSQL_DATA_DIR/mysql"

if [ ! -d "$MYSQL_DB_DIR" ]; then
  echo "Initializing MariaDB data directory..."
  mysql_install_db --user=mysql --datadir="$MYSQL_DATA_DIR"
fi

cat << EOF > /tmp/init.sql
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

exec mysqld --user=mysql --datadir="$MYSQL_DATA_DIR" --init-file=/tmp/init.sql
