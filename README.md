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

Add to /etc/docker/daemon.json for metrics

```
{  
 "metrics-addr": "172.17.0.1:9323",  
}
```

## install

### clone repo

```sh
git clone https://github.com/fvhome-vr/mydocker.git
cd mydocker
```

### set your envirement.

```sh
mv env.default .env
vim .env
```

### make deploy
First, create the directories and set permissions. Then, run the temporary letsencrypt_setup and nginx_setup on port 80/tcp to get the first SSL certificate.
When the symbolic link is created, use CTRL+C to terminate the first process and initiate the deployment of main services.

```sh
chmod +x deply.sh
bash ./deploy.sh
```

## after installation

link: https://${DOMAIN}

1. Setting external storage

Go to `Administration -> External storage`

Add storage:

- Photo - Local - None - /var/www/html/data/media_libary/photo
- Music - Local - None - /var/www/html/data/media_libary/music
- Torrents - Local - None - /var/www/html/data/media_libary/transmission/complete

Тестовая запись2
