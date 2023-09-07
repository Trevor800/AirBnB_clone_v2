#!/usr/bin/env bash
# Update package lists and install Nginx
sudo apt-get update
sudo apt-get install -y nginx

# Create necessary directories
sudo mkdir -p /data/web_static/releases/test /data/web_static/shared

# Create a fake HTML file
echo "Welcome to AirBnB" | sudo tee /data/web_static/releases/test/index.html > /dev/null

# Create or recreate symbolic link
sudo ln -sf /data/web_static/releases/test /data/web_static/current

# Give ownership to the ubuntu user and group recursively
sudo chown -R ubuntu:ubuntu /data/

# Update Nginx configuration
nginx_config="location /hbnb_static {
    alias /data/web_static/current;
}"

# Check if the configuration already exists, if not, add it
if ! sudo grep -q "location /hbnb_static" /etc/nginx/sites-available/default; then
    echo "$nginx_config" | sudo tee -a /etc/nginx/sites-available/default > /dev/null
fi

# Restart Nginx
sudo service nginx restart
