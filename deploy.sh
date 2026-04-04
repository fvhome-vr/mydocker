#!/usr/bin/env bash

source .env

if [ ! -h "${CONF_DIR}/nginx/certs/${DOMAIN}.crt" ]; then
    echo "Start setup.."
    mkdir -p "${DATA_DIR}/prometheus"
    mkdir -p "${MEDIA_LIBARY}/{music,photo,video}"
    mkdir -p "${MEDIA_LIBARY}/transmission/{complete,incomplete}"
    chown "${WWW_USER_UID}":"${WWW_USER_GID}" -R "${DATA_DIR}" "${MEDIA_LIBARY}"
    chmod g+s -R "${DATA_DIR}" "${MEDIA_LIBARY}"
    
    docker compose up -d --profile setup --abort-on-container-exit
    if [ $? -ne 0 ]; then
        echo "Setup error. Stop"
        exit 1
    fi
    docker compose rm -f
fi

docker compose up -d --profile main
if [ $? -ne 0 ]; then
    echo "Deploy error. Stop"
    exit 1
fi

if [ "${DEPLOY_MONITORING}" = "true" ]; then
    docker compose up -d --profile monitoring
    if [ $? -ne 0 ]; then
        echo "Deploy monitoring. Stop"
        exit 1
    fi
fi