# Generate certificates for gateways
> Created: 2023-04-11

These steps need to be run before the VMs started, otherwise the certificates and private keys cannot be loaded into the VMs.

First install the dependency on the host machine.

```shell
sudo apt install strongswan-pki
```

Run `scripts/gen_cert.sh` at the **root directory of the project**. Make sure the `pki` folder is generated.

Create the VMs, the VMs that have a certificate are `gateway-a`, `gateway-b`, and `gateway-s`.

```shell
vagrant up [vm]
```

See [Certificates Quickstart :: strongSwan Documentation](https://docs.strongswan.org/docs/5.9/pki/pkiQuickstart.html) for more information.