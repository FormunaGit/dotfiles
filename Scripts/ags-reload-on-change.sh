#!/usr/bin/env bash

CONFIG_DIR="$HOME/home-manager/Shell/"

# Watch for changes in AGS's configuration directory
while inotifywait -e modify,create,delete -r "$CONFIG_DIR"; do
  echo "AGS configuration changed. Restarting AGS..."
  kill "$(pidof gjs)"
  ags run /home/formuna/.config/home-manager/dotfiles/ags/ &
done
