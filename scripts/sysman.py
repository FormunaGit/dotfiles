#!/usr/bin/env python3
import os
import time
import random
import argparse

# SS = ShellStart. A custom script for simple welcome-like messages when opening a shell.
class SS:
    QUOTES = [
        'haii welcome to teh tewminal :3', "play ultrakill >:3",
        "nixos is the best", "powered by hyprland",
        "i use nixos btw", "RISE AND SHINE, MR FREEMAN. RISE AND SHINE.",
        "Have you remembered to rebuild your system yet?", 'PYTHON IS NOT A BABY LANGUAGE PYTHON IS NOT A BABY LANGUAGE PYTHON IS NOT A BABY LANGUAGE PYTHON IS NOT A BABY LANGUAGE',
        'Powered by JetBrains!', 'Moo moo?',
        'ULTRAKILL IS THE BEST GAME!', 'What if instead of Discord it was called Freakycord?',
        'Powered by piracy!', 'Declarative imports, yum!'
    ]
    COWS = [
        'tux',
        'daemon',
        'dragon',
        'default',
        'small',
        'stegosaurus',
        'moose',
        'milk',
        'flaming-sheep',
        'elephant',
    ]
    def __init__(self):
        q = random.choice(self.QUOTES); c = random.choice(self.COWS); dcs = random.randint(1, 20) * 0.1 # One line, three variables created for easy reading. I know this looks cursed.
        print(f'c={c}/dcs={dcs}')
        os.system(f'echo {q} | cowsay -f {c} | dotacat -p {dcs}')


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="A script for making my life easier, and more stylish.")
    parser.add_argument('-s', '--shell-start', action='store_true', help="Display a nice quote on shell start")


    args = parser.parse_args()

    if args.shell_start:
        SS()