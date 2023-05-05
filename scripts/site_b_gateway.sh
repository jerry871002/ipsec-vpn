#!/usr/bin/env bash

##### Setup iptables rules #####

# NAT traffic going to the internet
route add default gw 172.16.16.1
iptables -t nat -A POSTROUTING -o enp0s8 -j MASQUERADE

# Redirect traffic that was going to the local server to the cloud server
# DNAT stands for Destination NAT
ip addr add 10.1.0.99/16 dev enp0s9
iptables -t nat -A PREROUTING -p tcp -d 10.1.0.99 --dport 8080 -j DNAT --to-destination 172.48.48.52:8080

# Save the iptables rules
iptables-save > /etc/iptables/rules.v4
ip6tables-save > /etc/iptables/rules.v6

##### Setup strongSwan site-to-site VPN #####

# install swanctl
apt-get update -y
apt-get install -y strongswan-swanctl charon-systemd

# Root CA certificate
cp /vagrant/pki/cert/rootCACert.pem /etc/swanctl/x509ca/

# Site B certificate
cp /vagrant/pki/cert/siteBCert.pem /etc/swanctl/x509/

# Site B private key
cp /vagrant/pki/key/siteBKey.pem /etc/swanctl/private/

# swanctl configurations
cp /vagrant/config/swanctl-site-b.conf /etc/swanctl/swanctl.conf

# load the certificates and private keys into the charon daemon
swanctl --load-creds

# load the connections defined in swanctl.conf
swanctl --load-conns