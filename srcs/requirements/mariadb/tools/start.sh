#!/bin/bash

if [ ! -d "/var/lib/mysql/mysql" ]; then
  mysql_install_db --user=$DB_USER --datadir=/var/lib/mysql
fi

cat << EOF > /etc/mysql/init.sql
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

exec mysqld