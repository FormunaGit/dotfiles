#!/usr/bin/env bash

CONFIG_DIR="/etc/nixos/Shell/"

# Watch for changes in AGS's configuration directory
while inotifywait -e modify,create,delete -r "$CONFIG_DIR"; do
  echo "AGS configuration changed. Restarting AGS..."
  pkill gjs
  pkill gjs
  ags run $CONFIG_DIR &
done
