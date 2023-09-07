#!/usr/bin/env bash
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
