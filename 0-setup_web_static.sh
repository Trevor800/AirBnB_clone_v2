#!/usr/bin/env bash

# Install Nginx if not already installed
if ! dpkg -l | grep -q nginx; then
    sudo apt-get update
    sudo apt-get -y install nginx
fi

# Create necessary directories if they don't exist
sudo mkdir -p /data/web_static/releases/test/
sudo mkdir -p /data/web_static/shared/

# Create a fake HTML file for testing
echo "Hello, web_static test page!" | sudo tee /data/web_static/releases/test/index.html

# Create or recreate the symbolic link
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

# Give ownership of /data/ to ubuntu user and group recursively
sudo chown -R ubuntu:ubuntu /data/

# Update Nginx configuration
config_file="/etc/nginx/sites-available/default"
config_block="location /hbnb_static/ { alias /data/web_static/current/; }"

# Check if config_block already exists, if so, remove it first
if sudo grep -q "$config_block" "$config_file"; then
    sudo sed -i "/$config_block/d" "$config_file"
fi

# Add the new config_block
sudo sed -i "/server {/a $config_block" "$config_file"

# Restart Nginx to apply changes
sudo service nginx restart

# Exit successfully
exit 0
