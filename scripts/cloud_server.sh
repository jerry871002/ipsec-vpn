#!/usr/bin/env bash

# Install docker
apt-get update -y
apt-get install -y docker.io

## Build app image
cp /vagrant/scripts/Dockerfile /home/vagrant/server_app
cd /home/vagrant/server_app
docker build -t server-app:v1 .

## Traffic going to the internet
route add default gw 10.1.0.1

## Save the iptables rules
iptables-save > /etc/iptables/rules.v4
ip6tables-save > /etc/iptables/rules.v6

# Run app
docker run -p 8080:8080 -d --name site-a-server server-app:v1
docker run -p 8081:8080 -d --name site-b-server server-app:v1
