#!/bin/bash
apt-get update
apt-get install -y docker.io
systemctl start docker
systemctl enable docker

sleep 10

docker run -d \
  --restart always \
  -p 80:5000 \
  -e REDIS_HOST=${redis_host} \
  -e MYSQL_HOST=${mysql_host} \
  -e MYSQL_USER=admin \
  -e MYSQL_PASSWORD=password \
  -e MYSQL_DATABASE=users \
  alidevs/capstone-flask-app:latest
