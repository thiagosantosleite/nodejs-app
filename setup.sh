#!/bin/bash
yum update -y

### install node lts
wget https://nodejs.org/dist/v12.16.0/node-v12.16.0-linux-x64.tar.xz
VERSION=v12.16.0
DISTRO=linux-x64
mkdir -p /usr/local/lib/nodejs
tar -xJvf node-$VERSION-$DISTRO.tar.xz -C /usr/local/lib/nodejs

cat > ~/.profile <<EOF
VERSION=v12.16.0
DISTRO=linux-x64
export PATH=/usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin:$PATH
EOF

cat ~/.profile
. ~/.profile

## install pm2 and start app using one processo for each cpu
npm install pm2 -g
cd src
pm2 start app.js -i max 


## install python3 for parser and nginx for the reverse proxy
amazon-linux-extras install nginx1.12 -y
amazon-linux-extras install python3 -y


## setup ssl for nginx, self signed certificate
mkdir -p /usr/local/nginx/ssl
cd /usr/local/nginx/ssl
if [[ -z $SITE_IP ]]; then SITE_IP=18.207.186.2; echo "SITE_IP is not configured, so using 18.207.186.2"; fi;
openssl req -x509 -nodes -newkey rsa:2048 -keyout cert.key -out cert.crt -days 365 -subj "/C=BR/ST=Rio Grande do Sul/L=POA/O=xxxxx/CN=$SITE_IP"

## setup reverse proxy
cat > /etc/nginx/nginx.conf << EOF
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '[\$time_local] - "\$request" \$status';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    server {
     listen 80;
     server_name localhost;

     location / {
         proxy_set_header   X-Forwarded-For localhost;
         proxy_set_header   Host localhost;
         proxy_pass         http://localhost:3000;
     }
   }
   server {
     listen 443 ssl;
     server_name         localhost;
     ssl_certificate     /usr/local/nginx/ssl/cert.crt;
     ssl_certificate_key /usr/local/nginx/ssl/cert.key;
     ssl_protocols       SSLv3 TLSv1 TLSv1.1 TLSv1.2;
     ssl_ciphers         HIGH:!aNULL:!MD5;
     location / {
         proxy_set_header   X-Forwarded-For localhost;
         proxy_set_header   Host localhost;
         proxy_pass         http://localhost:3000;
     }

   }
}
EOF
sudo systemctl restart nginx

