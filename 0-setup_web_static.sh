#!/usr/bin/env bash
<<<<<<< HEAD
# Sets up a web server for deployment of web_static.

apt-get update
apt-get install -y nginx

mkdir -p /data/web_static/releases/test/
mkdir -p /data/web_static/shared/
echo "Holberton School" > /data/web_static/releases/test/index.html
ln -sf /data/web_static/releases/test/ /data/web_static/current

chown -R ubuntu /data/
chgrp -R ubuntu /data/

printf %s "server {
    listen 80 default_server;
    listen [::]:80 default_server;
    add_header X-Served-By $HOSTNAME;
    root   /var/www/html;
    index  index.html index.htm;

    location /hbnb_static {
	alias /data/web_static/current;
	index index.html index.htm;
    }

    location /redirect_me {
	return 301 http://cuberule.com/;
    }

    error_page 404 /404.html;
    location /404 {
      root /var/www/html;
      internal;
    }
}" > /etc/nginx/sites-available/default

service nginx restart
=======
# Update package lists to ensure we have the latest package information
sudo apt-get -y update

# Install Nginx web server
sudo apt-get -y install nginx

# Create necessary directories for web_static deployment
sudo mkdir -p /data/ /data/web_static/ /data/web_static/releases/ /data/web_static/shared/ /data/web_static/releases/test/

# Create a simple HTML file for testing purposes and store it in the appropriate location
echo "Holberton School for the win!" | sudo tee /data/web_static/releases/test/index.html > /dev/null

# Remove any existing symbolic link at /data/web_static/current
sudo rm -rf /data/web_static/current

# Create a symbolic link to make /data/web_static/releases/test/ the current version
sudo ln -s /data/web_static/releases/test/ /data/web_static/current

# Change ownership of the /data/ directory and its contents to the 'ubuntu' user and group
sudo chown -R ubuntu:ubuntu /data/

# Define an Nginx server configuration block for serving /hbnb_static/
server="\\\tlocation /hbnb_static/ {\n\t\talias /data/web_static/current/;\n\t}\n"

# Insert the server configuration block into the Nginx default site configuration
sudo sed -i "38i $server" /etc/nginx/sites-available/default

# Restart Nginx to apply the new configuration
sudo service nginx restart
>>>>>>> d490cc07d8041124ab6566520629c8ebc8031d19
