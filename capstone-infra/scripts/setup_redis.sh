#!/bin/bash

apt-get update
apt-get install -y docker.io

systemctl start docker
systemctl enable docker

docker run -d \
  --name redis \
  --restart always \
  -p 6379:6379 \
  redis:latest
