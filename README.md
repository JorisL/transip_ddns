# transip_ddns
Dynamic DNS for domain names registered at TransIP, using the TransIP API

## Usage
This is an example docker-compose entry
```yaml
version: "3"
services:
  transip_ddns:
    networks:
      - default
    environment:
      - DOMAIN_NAME=<yourdomainhere.com>
    volumes:
      - "<config_directory>:/root/.config/transip-api"
```
