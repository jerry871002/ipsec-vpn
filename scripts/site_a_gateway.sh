#!/usr/bin/env bash

## NAT traffic going to the internet
route add default gw 172.16.16.1
iptables -t nat -A POSTROUTING -o enp0s8 -j MASQUERADE

## Save the iptables rules
iptables-save > /etc/iptables/rules.v4
ip6tables-save > /etc/iptables/rules.v6

# install swanctl
sudo apt-get update -y
sudo apt-get install -y strongswan-swanctl

# Root CA certificate
cp /vagrant/pki/cert/rootCACert.pem /etc/swanctl/x509ca/

# Site A certificate
cp /vagrant/pki/cert/siteACert.pem /etc/swanctl/x509/

# Site A private key
cp /vagrant/pki/key/siteAKey.pem /etc/swanctl/private/

# swanctl configurations
cp /vagrant/config/swanctl-site-a.conf /etc/swanctl/swanctl.conf