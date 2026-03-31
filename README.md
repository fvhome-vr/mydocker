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

### recomendations before deploy

1. Add to /etc/docker/daemon.json for metrics 

```
{  
 "metrics-addr": "172.17.0.1:9323",  
}
```

2. Create directory ${DATA_DIR} and ${MEDIA_LIBARY} and set ${WWW_USER} owner permissions

```
mkdir -p ${DATA_DIR}
mkdir -p ${MEDIA_LIBARY}/{music,photo,video}
mkdir -p ${MEDIA_LIBARY}/transmission/{complete,incomplete}
chown ${WWW_USER_UID}:${WWW_USER_GID} -R ${DATA_DIR} ${MEDIA_LIBARY}
chmod g+s -R ${DATA_DIR}
```

## install

```
git clone https://github.com/fvhome-vr/mydocker.git
cd mydocker
mv env.default .env
# set your envirement
vim .env
docker compose up -d
```

## after installation

link: https://${DOMAIN}

External storage

Go to Administration -> External storage 
Add storage
Photo - Local - None - /var/www/html/data/media_libary/photo
Music - Local - None - /var/www/html/data/media_libary/music
Torrents - Local - None - /var/www/html/data/media_libary/transmission/complete
