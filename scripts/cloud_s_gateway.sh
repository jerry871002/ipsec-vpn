#!/usr/bin/env bash

##### Install swanctl #####

apt-get update -y
apt-get install -y strongswan-swanctl charon-systemd

## Traffic going to the internet
route add default gw 172.30.30.1

# # NAT traffic
# iptables -t nat -A POSTROUTING -o enp0s8 -j MASQUERADE

# Redirect traffic to the dedicated server
iptables -t nat -A PREROUTING -p tcp -s 172.16.16.16 --dport 8080 -j DNAT --to-destination 10.1.0.2:8080
iptables -t nat -A PREROUTING -p tcp -s 172.16.18.18 --dport 8080 -j DNAT --to-destination 10.1.0.2:8081

## Save the iptables rules
iptables-save > /etc/iptables/rules.v4
ip6tables-save > /etc/iptables/rules.v6

# Root CA certificate
cp /vagrant/pki/cert/rootCACert.pem /etc/swanctl/x509ca/

# Cloud S certificate
cp /vagrant/pki/cert/cloudSCert.pem /etc/swanctl/x509/

# Cloud S private key
cp /vagrant/pki/key/cloudSKey.pem /etc/swanctl/private/

# swanctl configurations
cp /vagrant/config/swanctl-cloud-s.conf /etc/swanctl/swanctl.conf

# load the certificates and private keys into the charon daemon
swanctl --load-creds

# load the connections defined in swanctl.conf
swanctl --load-conns