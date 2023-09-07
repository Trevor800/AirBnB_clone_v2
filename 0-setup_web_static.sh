#!/usr/bin/env bash
# Bash script to set up web servers for web_static deployment

# Update package list and install Nginx
apt-get -y update
apt-get -y install nginx

# Create directories if they don't exist
mkdir -p /data/web_static/releases/test
mkdir -p /data/web_static/shared

# Create a simple HTML file
echo "Welcome to AirBnB" > /data/web_static/releases/test/index.html

# Create a symbolic link
ln -sf /data/web_static/releases/test /data/web_static/current

# Set ownership to the ubuntu user
chown -R ubuntu:ubuntu /data/

# Configure Nginx to serve /hbnb_static
config_file="/etc/nginx/sites-available/default"
nginx_config="\nlocation /hbnb_static/ {\n\talias /data/web_static/current/;\n}\n"
sed -i "/server_name _;/a $nginx_config" $config_file

# Restart Nginx to apply changes
service nginx restart
