FROM debian:buster


RUN apt-get update && \
    apt-get install -y 
    # --no-install-recommends \
        nginx \
        openssl 
        # && \
    # apt-get clean 
    # && \
    # rm -rf /var/lib/apt/lists/*

# RUN mkdir -p /etc/ssl/private

ENV SSL_DIR="/etc/ssl/private" \
    CERT_VALID_DAYS=365 \
    KEY_LENGTH=2048

RUN openssl req -x509 -nodes -days ${CERT_VALID_DAYS} \
    -newkey rsa:${KEY_LENGTH} -keyout ${SSL_DIR}/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=DE/ST=BW/L=Heilbronn/O=42Heilbronn/CN=ssanei.42.fr" \
    # && rm -rf /var/lib/apt/lists/*

EXPOSE 443

COPY ./conf/default /etc/nginx/sites-available/default

CMD [ "nginx", "-g", "daemon off;" ]
