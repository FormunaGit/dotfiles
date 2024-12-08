#!/usr/bin/env bash

printf "Hello World!\n"
printf "This is the install script for Formuna's Dotfiles!\n"

printf "This script will install everything as if it was ran on NixOS.\n"
printf "If you are not running NixOS, DO NOT RUN THIS SCRIPT!\n"

printf "Continue? [y/N] "
read -r response
if [ "$response" != "Y" ] && [ "$response" != "y" ]; then
    exit 0
else
    if [ ! -e /etc/NIXOS ]; then
        printf "You are not running NixOS! Exiting.\n"
        exit 1
    else
        printf "You are running NixOS!\nDotfiles are being installed!\n"
        # TODO: actually make this. nixos system config is in ./dotfiles/nixos/ so it should be easy... right?
    fi
fi