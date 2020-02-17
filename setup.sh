#!/bin/bash
yum update -y

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
npm install pm2 -g

cd src
pm2 start app.js -i max



amazon-linux-extras install nginx1.12 -y
amazon-linux-extras install python3 -y

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
}
EOF
sudo systemctl restart nginx

