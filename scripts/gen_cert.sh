#!/usr/bin/env bash

mkdir -p pki/{key,req,cert}

##### Root CA #####

# generates an elliptic Edwards-Curve key
# with a cryptographic strength of 128 bits
# rootCAKey.pem is the generated private key
pki --gen --type ed25519 --outform pem > pki/key/rootCAKey.pem

# generates a self-signed X.509 certificate
# with a lifetime of 10 years (3652 days)
pki --self --ca --lifetime 3652 --in pki/key/rootCAKey.pem \
           --dn "C=FI, O=Network Security, CN=Network Security Root CA" \
           --outform pem > pki/cert/rootCACert.pem


##### Site A #####

pki --gen --type ed25519 --outform pem > pki/key/siteAKey.pem

# generates a PKCS#10 certificate request
# use IPv4 address as subjectAltName
pki --req --type priv --in pki/key/siteAKey.pem \
          --dn "C=FI, O=Network Security, CN=Site A" \
          --san 172.16.16.16 --outform pem > pki/req/siteAReq.pem

# generates an X.509 certificate signed with a CA’s private key
# with a lifetime of 5 years (1826 days)
pki --issue --cacert pki/cert/rootCACert.pem --cakey pki/key/rootCAKey.pem \
            --type pkcs10 --in pki/req/siteAReq.pem --lifetime 1826 \
            --outform pem > pki/cert/siteACert.pem


##### Site B #####

pki --gen --type ed25519 --outform pem > pki/key/siteBKey.pem
pki --req --type priv --in pki/key/siteBKey.pem \
          --dn "C=FI, O=Network Security, CN=Site B" \
          --san 172.18.18.18 --outform pem > pki/req/siteBReq.pem
pki --issue --cacert pki/cert/rootCACert.pem --cakey pki/key/rootCAKey.pem \
            --type pkcs10 --in pki/req/siteBReq.pem --lifetime 1826 \
            --outform pem > pki/cert/siteBCert.pem


##### Cloud S #####

pki --gen --type ed25519 --outform pem > pki/key/cloudSKey.pem
pki --req --type priv --in pki/key/cloudSKey.pem \
          --dn "C=FI, O=Network Security, CN=Cloud S" \
          --san 172.30.30.30 --outform pem > pki/req/cloudSReq.pem
pki --issue --cacert pki/cert/rootCACert.pem --cakey pki/key/rootCAKey.pem \
            --type pkcs10 --in pki/req/cloudSReq.pem --lifetime 1826 \
            --outform pem > pki/cert/cloudSCert.pem