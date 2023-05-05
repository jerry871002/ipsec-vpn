# Site-to-site VPN
> Created: 2023-04-11

We have to create two tunnels, one between **Site A** and **Cloud S**, another between **Site B** and **Cloud S**.

All the configuration files are stored under `config/`. They will be loaded into the VMs during start up.

## Resources
- [Configuration Quickstart :: strongSwan Documentation](https://docs.strongswan.org/docs/5.9/config/quickstart.html#_host_to_host_case)
- [swanctl.conf :: strongSwan Documentation](https://docs.strongswan.org/docs/6.0/swanctl/swanctlConf.html)
- [IKEv2 Configuration Examples :: strongSwan Documentation](https://docs.strongswan.org/docs/5.9/config/IKEv2.html)
- [IKEv2 | Site-to-Site | RSA authentication with X.509 certificates | IPv4](https://www.strongswan.org/testing/testresults/ikev2/net2net-cert/)