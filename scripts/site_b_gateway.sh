#!/usr/bin/env bash

## NAT traffic going to the internet
route add default gw 172.18.18.1
iptables -t nat -A POSTROUTING -o enp0s8 -j MASQUERADE

## Save the iptables rules
iptables-save > /etc/iptables/rules.v4
ip6tables-save > /etc/iptables/rules.v6

# install swanctl
sudo apt-get update -y
sudo apt-get install -y strongswan-swanctl

# Root CA certificate
cp /vagrant/pki/cert/rootCACert.pem /etc/swanctl/x509ca/

# Site B certificate
cp /vagrant/pki/cert/siteBCert.pem /etc/swanctl/x509/

# Site B private key
cp /vagrant/pki/key/siteBKey.pem /etc/swanctl/private/

# swanctl configurations
cp /vagrant/config/swanctl-site-b.conf /etc/swanctl/swanctl.conf