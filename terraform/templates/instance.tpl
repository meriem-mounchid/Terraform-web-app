#!/bin/bash

sudo apt-get update
sudo apt install docker.io -y
sudo apt install wget curl -y
sudo groupadd docker
sudo usermod -aG docker ubuntu
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo git clone https://github.com/meriem-mounchid/app-test-01.git app
sudo chmod 777 /app/.env 
sudo mkdir -p /home/ubuntu/wordpress_nginx
sudo mkdir /home/ubuntu/wordpress_nginx
sudo echo "WORDPRESS_DB_HOST="${db_endpoint} >> /app/.env
sudo echo "IP_WP="${lb_name} >> /app/.env
sudo echo "WORDPRESS_DB_PASSWORD="${password} >> /app/.env
sudo echo "WORDPRESS_DB_NAME="${db_name} >> /app/.env
sudo echo "WORDPRESS_DB_USER="${db_user} >> /app/.env
sudo echo "WORDPRESS_ROOT_USER="${wp_user} >> /app/.env
sudo echo "WORDPRESS_ROOT_PASSWORD="${wp_password} >> /app/.env
sudo echo "MYIP="$(curl http://169.254.169.254/latest/meta-data/instance-id) >> /app/.env
sudo docker-compose -f /app/docker-compose.yaml up --build -d