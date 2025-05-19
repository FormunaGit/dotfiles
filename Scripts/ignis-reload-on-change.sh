#!/usr/bin/env bash

CONFIG_DIR="/etc/nixos/PyShell/"

ignis init -c ~/nixos/PyShell/config.py &

# Watch for changes in Ignis's configuration directory
while inotifywait -e modify,create,delete -r "$CONFIG_DIR"; do
  echo "Ignis configuration changed. Restarting Ignis..."
  pkill ignis
  ignis init -c ~/nixos/PyShell/config.py &
done
