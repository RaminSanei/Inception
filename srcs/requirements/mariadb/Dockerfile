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

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    mariadb-server \
    curl \
    gettext \
    && rm -rf /var/lib/apt/lists/*  # Clean up the apt cache to reduce image size

COPY ./tools/start.sh /start.sh

RUN mkdir -p /var/lib/mysql/mysql /docker-entrypoint-initdb.d /var/run/mysqld /etc/mysql/conf.d /var/log/mysql \
    && chmod +x /start.sh

COPY ./conf/50-server.cnf /etc/mysql/50-server.cnf

EXPOSE 3306

# CMD [ "/start.sh" ]
ENTRYPOINT [ "/start.sh" ]