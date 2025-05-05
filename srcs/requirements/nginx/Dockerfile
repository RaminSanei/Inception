FROM debian:buster


RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        nginx \
        openssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl

ENV SSL_DIR="/etc/nginx/ssl" \
    CERT_VALID_DAYS=365 \
    KEY_LENGTH=2048

RUN openssl req -x509 -nodes -days ${CERT_VALID_DAYS} \
    -newkey rsa:${KEY_LENGTH} -keyout ${SSL_DIR}/server.key \
    -out ${SSL_DIR}/server.crt \
    -subj "/C=DE/ST=BW/L=Heilbronn/O=42Heilbronn/CN=ssanei.42.fr" \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 443

COPY ./conf/default.conf /etc/nginx/sites-available/default

CMD [ "nginx", "-g", "daemon off;" ]
