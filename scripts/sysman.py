#!/usr/bin/env python3
import os
import time
import random
import argparse

# SS = ShellStart
SS_QUOTES = [
    "haii welcome to teh tewminal :3", "play ultrakill >:3",
    "nixos is the best", "powered by hyprland",
    "i use nixos btw", "RISE AND SHINE, MR FREEMAN. RISE AND SHINE.",
]

def shell_start():
    quote = random.choice(SS_QUOTES)
    print(quote)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="A script for making my life easier, and more stylish.")
    parser.add_argument('-s', '--shell-start', action='store_true', help="Display a nice quote on shell start")

    args = parser.parse_args()

    if args.shell_start:
        shell_start()