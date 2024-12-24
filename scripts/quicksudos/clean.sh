#!/usr/bin/env bash

nix-collect-garbage -d
/run/current-system/bin/switch-to-configuration boot