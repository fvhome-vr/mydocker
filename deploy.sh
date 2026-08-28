#!/usr/bin/env bash

source .env

if [ ! -h "${CONF_DIR}/nginx/certs/${DOMAIN}.crt" ]; then
    echo "Start setup.."
    DOCKER80=$(docker ps -f status=running -f publish=80 -q)
    [ -n "${DOCKER80}" ] && docker stop "${DOCKER80}" && docker rm -f nginx
    mkdir -p ${DATA_DIR}/{prometheus,nextcloud,v2raya,gitea}
    mkdir -p ${MEDIA_LIBARY}/{music,photo,video}
    mkdir -p ${MEDIA_LIBARY}/transmission/{complete,incomplete}
    chown "${WWW_USER_UID}":"${WWW_USER_GID}" -R "${DATA_DIR}" "${MEDIA_LIBARY}"
    chmod g+s -R "${DATA_DIR}" "${MEDIA_LIBARY}"

    cleanup_setup() {
        echo -e "\nSetup interrupted by user. Stopping and removing setup containers..."
        kill $SETUP_PID 2>/dev/null
        docker compose --profile setup down
    }

    trap 'cleanup_setup' INT

    (docker compose --profile setup up --abort-on-container-exit 2>&1 | \
      grep --line-buffered  "letsencrypt_setup") &
    SETUP_PID=$!

    while kill -0 $SETUP_PID 2>/dev/null; do
        echo 'If the certificate is received, then use CTRL+C to go to the main deploy';
        sleep 5
    done

    trap - INT
fi

echo "Deploy main services.."
if [ -h "${CONF_DIR}/nginx/certs/${DOMAIN}.crt" ]; then
  docker compose --profile main up -d
else
  echo "Error: Certificate not found. Stop"
fi

exit
