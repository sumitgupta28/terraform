#! /bin/bash

set -e
echo "*****    Installing Nginx    *****"
sudo apt update
sudo apt install -y nginx
sudo systemctl enable nginx
sudo systemctl restart nginx

echo "*****   Installation Complteted!!   *****"
#echo "Welcome to Google Compute VM Instance deployed using Terraform!!!" > /var/www/html
echo "*****   Startup script completes!!    *****"