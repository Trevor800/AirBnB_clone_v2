#!/usr/bin/env bash
# Install Nginx if not already installed
if ! command -v nginx &> /dev/null; then
    sudo apt-get update
    sudo apt-get -y install nginx
fi

# Create necessary folders
sudo mkdir -p /data/web_static/releases/test /data/web_static/shared

# Create a fake HTML file
echo "<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" | sudo tee /data/web_static/releases/test/index.html > /dev/null

# Create or recreate symbolic link
ln -sf /data/web_static/releases/test /data/web_static/current

# Give ownership to ubuntu user and group
sudo chown -R ubuntu:ubuntu /data/

# Update Nginx configuration
config_file="/etc/nginx/sites-available/default"
nginx_config="location /hbnb_static {
    alias /data/web_static/current;
}"

# Check if the configuration already exists, if not, add it
if ! grep -q "location /hbnb_static" "$config_file"; then
    sudo sed -i "/server_name _;/ a $nginx_config" "$config_file"
fi

# Restart Nginx
sudo service nginx restart
