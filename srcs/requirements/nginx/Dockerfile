# 
FROM debian:buster

# install nginx and openssl
RUN apt-get update && apt-get install -y nginx openssl

# copy the nginx configuration file
COPY ./conf/default /etc/nginx/sites-available/default
# openssl certificate creation for https
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key\
-out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=DE/ST=BW/L=Heilbronn/O=42Heilbronn/CN=${DOMAIN_NAME}"

# nginx start for web server
CMD ["nginx", "-g", "daemon off;"]
