#!/usr/bin/env bash
# Check if Nginx is installed, and if not, install it
if ! command -v nginx &>/dev/null; then
  apt-get update
  apt-get install nginx -y
fi

# Create the /data/web_static/releases/test directory
mkdir -p /data/web_static/releases/test

# Create the /data/web_static/shared directory
mkdir -p /data/web_static/shared

# Create the /data/web_static/releases/test/index.html file
echo "Holberton School" > /data/web_static/releases/test/index.html

# Create a symbolic link /data/web_static/current linked to the /data/web_static/releases/test/ folder
ln -sf /data/web_static/releases/test /data/web_static/current

# Give ownership of the /data/ folder to the ubuntu user AND group
chown -R ubuntu:ubuntu /data

# Update the Nginx configuration to serve the content of /data/web_static/current/ to hbnb_static
# (ex: https://mydomainname.tech/hbnb_static). Don't forget to restart Nginx after updating the configuration:

# Get the current Nginx configuration
nginx_config=$(cat /etc/nginx/sites-available/default)

# Add the following line to the Nginx configuration
echo "server {
  listen 80;
  server_name localhost;

  location /hbnb_static {
    alias /data/web_static/current;
  }
}
" >> $nginx_config

# Update Nginx
nginx -s reload

# The script should always exit successfully
exit 0
