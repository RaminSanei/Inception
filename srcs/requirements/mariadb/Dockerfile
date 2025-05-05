# FROM debian:buster

# # install maridb server
# RUN apt update && apt install -y mariadb-server openssl

# # copy the mariadb configuration file
# COPY ./tools/script.sh /mariadb/script.sh

# # WORKDIR /
# RUN chmod +x /mariadb/script.sh

# # Run the script
# ENTRYPOINT ["sh", "/mariadb/script.sh"]

FROM debian:buster

# Install MariaDB and necessary tools
RUN apt-get update && \
    apt-get install -y mariadb-server curl gettext && \
    rm -rf /var/lib/apt/lists/*

# Copy custom configs and scripts
COPY ./tools/start.sh /start.sh
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Prepare required directories
RUN mkdir -p /var/run/mysqld && \
    chmod 755 /start.sh

EXPOSE 3306

ENTRYPOINT ["/start.sh"]
