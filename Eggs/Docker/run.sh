#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "Usage: $0 <container_name>"
    exit 1
elif [ "$1" == "nextcloud" ]; then
    cd Nextcloud-AIO
    docker compose up -d
    cd ..
    exit 0
fi