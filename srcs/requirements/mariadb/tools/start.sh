# #!/bin/bash

# MYSQL_DATA_DIR="/var/lib/mysql"
# MYSQL_DB_DIR="$MYSQL_DATA_DIR/mysql"

# if [ ! -d '${MYSQL_DB_DIR}' ]; then
#   mysql_install_db --user=$DB_USER --datadir='${MYSQL_DATA_DIR}'
# fi

# cat << EOF > /etc/mysql/init.sql
# CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
# CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
# GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%' WITH GRANT OPTION;
# ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
# FLUSH PRIVILEGES;
# EOF

# exec mysqld

#!/bin/bash

MYSQL_DATA_DIR="/var/lib/mysql"
MYSQL_DB_DIR="$MYSQL_DATA_DIR/mysql"

# Initialize DB only if it hasn't been created
if [ ! -d "$MYSQL_DB_DIR" ]; then
  echo "Initializing database..."
  mysqld --user=$DB_USER --initialize-insecure --datadir="$MYSQL_DATA_DIR"
fi

# Create SQL init file
cat << EOF > /etc/mysql/init.sql
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%' WITH GRANT OPTION;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

# Start MariaDB
exec mysqld
