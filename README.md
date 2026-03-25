# mydocker

It's compose file for deploy to standalone home server:
- plex
- nextcloud
- nginx and letsencrypt
- transmission
- tor
- monitoring:
  - prometheus
  - alertmanager
  - pushgateway
  - node-exporter
  - cAdvisor
  - cert-exporter

### recomendations

to do

## configuration files

to do:
- add templates for $CONF_DIR
- instructions

## install

```
git clone https://github.com/fvhome-vr/mydocker.git
cd mydocker
mv env.default .env
# set your envirement
vim .env
docker compose up -d
```

