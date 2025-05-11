FROM debian:buster

RUN apt-get update && \
    apt-get install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/*

RUN openssl req -x509 -nodes -days 365 \
-newkey rsa:4096 \
-keyout /etc/ssl/private/nginx-selfsigned.key \
-out /etc/ssl/certs/nginx-selfsigned.crt \
-subj "/C=DE/ST=Baden-Wurttemberg/L=Heilbronn/O=42/OU=Student/CN=ssanei.42.fr"

COPY ./conf/default.conf /etc/nginx/sites-available/default

CMD ["nginx", "-g", "daemon off;"]
