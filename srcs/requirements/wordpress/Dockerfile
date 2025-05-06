FROM debian:buster

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    php-fpm \
    php-mysqli \
    curl

COPY tools/setup.sh /usr/local/bin/setup.sh

RUN chmod +x /usr/local/bin/setup.sh

RUN curl -sS https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp

RUN mkdir -p /run/php

RUN sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf && \
    mkdir -p /var/www/html /var/log/php &&
    chown -R www-data:www-data /var/www/html /run/php && \
    chmod -R 755 /var/www/html


# WORKDIR /var/www/html

ENTRYPOINT ["/usr/local/bin/setup.sh"]
# CMD ["/usr/local/bin/setup.sh"]
