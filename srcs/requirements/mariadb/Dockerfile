FROM debian:buster 

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/*


COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/start.sh /mariadb/start.sh

RUN mkdir -p /docker-entrypoint-initdb.d \
    /run/mysqld \
    /etc/mysql/mariadb.conf.d && chmod +x /mariadb/start.sh

# EXPOSE 3306

ENTRYPOINT ["sh","/mariadb/start.sh"]