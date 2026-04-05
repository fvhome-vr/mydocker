#!/usr/bin/env bash

source .env

if [ ! -h "${CONF_DIR}/nginx/certs/${DOMAIN}.crt" ]; then
    echo "Start setup.."
    mkdir -p ${DATA_DIR}/{prometheus,nextcloud}
    mkdir -p ${MEDIA_LIBARY}/{music,photo,video}
    mkdir -p ${MEDIA_LIBARY}/transmission/{complete,incomplete}
    chown "${WWW_USER_UID}":"${WWW_USER_GID}" -R "${DATA_DIR}" "${MEDIA_LIBARY}"
    chmod g+s -R "${DATA_DIR}" "${MEDIA_LIBARY}"
    docker compose --profile setup up --abort-on-container-exit
fi

# exit

echo "Deploy main services.."
if [ -h "${CONF_DIR}/nginx/certs/${DOMAIN}.crt" ]; then
  docker compose --profile main up -d
fi

exit
