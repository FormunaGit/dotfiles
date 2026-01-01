#!/usr/bin/env bash

CONFIG_DIR="$HOME/.config/ignis"

# Watch for changes in Ignis's configuration directory
while inotifywait -e modify,create,delete -r "$CONFIG_DIR"; do
  echo "Ignis configuration changed. Reloading Ignis..."
  ignis reload
done
