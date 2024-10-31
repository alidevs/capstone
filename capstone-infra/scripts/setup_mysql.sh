#!/bin/bash

apt-get update
apt-get install -y docker.io

systemctl start docker
systemctl enable docker

docker run -d \
  --name mysql \
  --restart always \
  -p 3306:3306 \
  -e MYSQL_ROOT_PASSWORD=mysqlpassword \
  -e MYSQL_DATABASE=capstone \
  -e MYSQL_USER=mysqluser \
  -e MYSQL_PASSWORD=mysqlpassword \
  mysql:latest
