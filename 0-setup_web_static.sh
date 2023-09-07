#!/usr/bin/env bash
# Check if Nginx is installed
if ! command -v nginx &>/dev/null; then
  apt-get update
  apt-get install nginx -y
fi

# Create the /data directory if it doesn't exist
if [ ! -d /data ]; then
  mkdir /data
fi

# Create the /data/web_static directory if it doesn't exist
if [ ! -d /data/web_static ]; then
  mkdir /data/web_static
fi

# Create the /data/web_static/releases directory if it doesn't exist
if [ ! -d /data/web_static/releases ]; then
  mkdir /data/web_static/releases
fi

# Create the /data/web_static/shared directory if it doesn't exist
if [ ! -d /data/web_static/shared ]; then
  mkdir /data/web_static/shared
fi

# Create the /data/web_static/releases/test directory if it doesn't exist
if [ ! -d /data/web_static/releases/test ]; then
  mkdir /data/web_static/releases/test
fi

# Create a fake HTML file /data/web_static/releases/test/index.html
echo "<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" > /data/web_static/releases/test/index.html

# Create a symbolic link /data/web_static/current linked to the /data/web_static/releases/test/ folder
if [ -L /data/web_static/current ]; then
  rm /data/web_static/current
fi

ln -s /data/web_static/releases/test /data/web_static/current

# Give ownership of the /data/ folder to the ubuntu user AND group
chown -R ubuntu:ubuntu /data

# Update the Nginx configuration to serve the content of /data/web_static/current/ to hbnb_static
# (ex: https://mydomainname.tech/hbnb_static). Don't forget to restart Nginx after updating the configuration:

echo "server {
  listen 80;
  server_name localhost;

  location /hbnb_static {
    alias /data/web_static/current;
  }
}
" > /etc/nginx/sites-available/default

nginx -s reload
