#!/usr/bin/env bash

CONFIG_DIR="$HOME/.config/waybar"

# Watch for changes in Waybar's configuration directory
while inotifywait -e modify,create,delete -r "$CONFIG_DIR"; do
  echo "Waybar configuration changed. Restarting Waybar..."
  pkill waybar
  waybar &
done