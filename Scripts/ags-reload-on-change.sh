#!/usr/bin/env bash

CONFIG_DIR="/home/formuna/home-manager/Shell/"

# Watch for changes in AGS's configuration directory
while inotifywait -e modify,create,delete -r "$CONFIG_DIR"; do
  echo "AGS configuration changed. Restarting AGS..."
  kill "$(pidof gjs)"
  ags run $COFNIG_DIR &
done
