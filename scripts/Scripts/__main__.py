"""
This is the Scripts folder!
This is where I put all the funny little scripts I make. (in Python of course)
"""
import argparse
import os
import random

quotes = [
    'Have you remembered to rebuild your system yet?', 'PYTHON IS NOT A BABY LANGUAGE PYTHON IS NOT A BABY LANGUAGE PYTHON IS NOT A BABY LANGUAGE PYTHON IS NOT A BABY LANGUAGE',
    'Powered by JetBrains!', 'Moo moo?',
    'ULTRAKILL IS THE BEST GAME!', 'What if instead of Discord it was called Freakycord?',
    'Powered by piracy!', 'Declarative imports, yum!'
]
cows = [
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

def shellstart():
    # Gets a random custom quote, forces a cow to say it and makes it ✨ rainbow! ✨
    quote = random.choice(quotes)
    cow = random.choice(cows)
    lccolor = random.randint(1, 20) * 0.1
    print(f'cow: {cow} | dotacat spread: {lccolor}')
    os.system(f'echo {quote} | cowsay -f {cow} | dotacat -p {lccolor}')

def nixedit():
    # Opens Neovim, allows the user to configure the required things
    os.system('nvim /etc/nixos/configuration.nix')
    res = input('Rebuild system? ')
    if res == 'yes' or res == 'y':
        print('Rebuilding system... (~> sudo nixos-rebuild switch <~)')
        print(res)
        os.system('sudo nixos-rebuild switch')
    else:
        print()

def update():
    print('Refreshing package list... (~> sudo nix-channel --update <~)')
    os.system('sudo nix-channel --update')
    print('Rebuilding system... (~> sudo nixos-rebuild switch <~)')
    os.system('sudo nixos-rebuild switch')

def clean():
    print('Cleaning...')
    os.system('sudo nix-collect-garbage --old')
    os.system('sudo /run/current-system/bin/switch-to-configuration boot')

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="A neat script for NixOS configuration")
    parser.add_argument('-s', help='The Shell Start command', action='store_true')
    parser.add_argument('-n', help='The Editnix/Nixedit command', action='store_true')
    parser.add_argument('-u', help='Update NixOS', action='store_true')
    args = parser.parse_args()
    if args.n:
        nixedit()
    elif args.s:
        shellstart()
    elif args.u:
        update()

