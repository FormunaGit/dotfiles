#!/usr/bin/env python3
import os
import random
import argparse

SS_QUOTES = [
    'haii welcome to teh tewminal :3', "play ultrakill >:3",
    "nixos is the best", "powered by hyprland",
    "i use nixos btw", "RISE AND SHINE, MR FREEMAN. RISE AND SHINE.",
    "Have you remembered to rebuild your system yet?",
    'PYTHON IS NOT A BABY LANGUAGE PYTHON IS NOT A BABY LANGUAGE PYTHON IS NOT A BABY LANGUAGE PYTHON IS NOT A BABY LANGUAGE',
    'Powered by Zed!', 'Moo moo?',
    'ULTRAKILL IS THE BEST GAME!', 'What if instead of Discord it was called Freakycord?',
    'Powered by piracy!', 'Declarative imports, yum!']
SS_COWS = [
    'tux',
    'daemon',
    'dragon',
    'default',
    'small',
    'stegosaurus',
    'moose',
    'milk',
    'flaming-sheep',
    'elephant',]

def ShellStart():
    quote = random.choice(SS_QUOTES)
    cow = random.choice(SS_COWS)
    dotacat_spread = random.randint(1, 20) * 0.1
    print(f'cow={cow}|spread={dotacat_spread}')
    os.system(f'echo {quote} | cowsay -f {cow} | dotacat -p {dotacat_spread}')

class Nix:
    @staticmethod
    def upgrade():
        print('Updating Nix packages...')
        os.system('cd /etc/nixos')
        print('Updating flake.lock file...')
        os.system('sudo nix flake update')
        print('Rebuilding system...')
        os.system('sudo nixos-rebuild switch --show-trace -L -v') # rebuild command + some debug flags
        print('Done! Please reboot.')

    @staticmethod
    def clean():
        print('Cleaning Nix packages...')
        os.system('sudo nix-collect-garbage -d')
        os.system('nix-collect-garbage -d')
        print('Done!')


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="A custom script for my system named \"unimag\".")
    subparser = parser.add_subparsers(dest='command')
    parser.add_argument('-s', '--shell-start', action='store_true', help="Strangely over-customized cowsay.")

    nix_subcommand = subparser.add_parser('nix', help="Nix related commands")
    nix_subcommand.add_argument('upgrade', help="Upgrade all Nix packages", action='store_true')
    nix_subcommand.add_argument('clean', help="Clean all Nix packages", action='store_true')

    args = parser.parse_args()

    if args.shell_start:
        ShellStart()
    elif args.command == 'nix' and args.upgrade:
        Nix.upgrade()
    elif args.command == 'nix' and args.clean:
        Nix.clean()
    else:
        parser.print_help()
