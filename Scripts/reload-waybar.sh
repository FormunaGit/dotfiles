#!/usr/bin/env bash

CONFIG_DIR="$HOME/.config/waybar"

# Watch for changes in AGS's configuration directory
while inotifywait -e modify,create,delete -r "$CONFIG_DIR"; do
  echo "Waybar configuration changed. Restarting Waybar..."
  kill "$(pidof waybar)"
  waybar &
done
