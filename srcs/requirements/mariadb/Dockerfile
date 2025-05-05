FROM debian:buster

# install maridb server
RUN apt update && apt install -y mariadb-server openssl

# copy the mariadb configuration file
COPY ./tools/script.sh /mariadb/script.sh

# WORKDIR /
RUN chmod +x /mariadb/script.sh

# Run the script
ENTRYPOINT ["sh", "/mariadb/script.sh"]
