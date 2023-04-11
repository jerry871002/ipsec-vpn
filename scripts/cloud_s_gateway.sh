#!/usr/bin/env bash

## Traffic going to the internet
route add default gw 172.30.30.1

## Currently no NAT
#iptables -t nat -A POSTROUTING -o enp0s8 -j MASQUERADE

## Save the iptables rules
iptables-save > /etc/iptables/rules.v4
ip6tables-save > /etc/iptables/rules.v6

# install swanctl
sudo apt-get update -y
sudo apt-get install -y strongswan-swanctl

# Root CA certificate
cp /vagrant/pki/cert/rootCACert.pem /etc/swanctl/x509ca/

# Cloud S certificate
cp /vagrant/pki/cert/cloudSCert.pem /etc/swanctl/x509/

# Cloud S private key
cp /vagrant/pki/key/cloudSKey.pem /etc/swanctl/private/

# swanctl configurations
cp /vagrant/config/swanctl-cloud-s.conf /etc/swanctl/swanctl.conf