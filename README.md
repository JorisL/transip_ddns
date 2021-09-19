# transip_ddns
Dynamic DNS for domain names registered at TransIP, using the TransIP API

This container checks every 15 minutes if the IP address of the host matches the IP address from the domain name set in the DOMAIN_NAME environment variable (which is assumed to be registered by TransIP and should point to the IP address of the host machine).
If these not match then it will configure TransIP to point the domain name to the host's current IP address.

## Installation / Usage
This is an example docker-compose entry
```yaml
version: "3"
services:
  transip_ddns:
    image: jorisl42/transip_ddns
    networks:
      - default
    environment:
      - DOMAIN_NAME=<yourdomainhere.com>
    volumes:
      - "<config_directory>:/root/.config/transip-api"
```

## Remarks
This tool uses the (wonderfull) [tipctl tool from TransIP](https://github.com/transip/tipctl/).
I'm not affiliated in any way with TransIP.
Use this tool at your own risk.
