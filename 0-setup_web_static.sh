#!/usr/bin/env bash
# Install Nginx if not already installed
apt-get update
apt-get install -y nginx
mkdir -p /data/web_static/releases/test
mkdir -p /data/web_static/shared
echo "Welcome to AirBnB" > /data/web_static/releases/test/index.html
ln -sf /data/web_static/releases/test /data/web_static/current
chown -R ubuntu:ubuntu /data/
serve="\n\tlocation \/hbnb_static {\n\t\talias \/data\/web_static\/current;\n\t}"
sed -i "s/^\tserver_name .*;$/&\n$serve/" /etc/nginx/sites-available/default
service nginx restart
