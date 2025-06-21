# Formuna's Dotfiles!
Hey there, came to copy my dots? I'd rather you copy from [N3RDIUM's](https://github.com/N3RDIUM/Zenith) since 90% of mine are from him.

## How do I install this?
These dotfiles are easily installable as a system flake, so the process to install it on a NixOS system is pretty easy:

1. Run `git clone https://github.com/FormunaGit/dotfiles`
2. Delete cloned `hardware-configuration.nix` file with `rm ./dotfiles/NewSystem/hardware-configuration.nix`
3. Move current system's `hardware-configuration.nix` with `cp /etc/nixos/hardware-configuration.nix ./dotfiles/NewSystem`
4. Delete the `/etc/nixos` folder with `sudo rm -rf /etc/nixos` (**WARNING: this will remove any configs you have in configuration.nix**)
5. Symlink the `dotfiles` folder to `/etc/nixos` with `sudo ln -s ./dotfiles/ /etc/nixos/`

## What's it look like?
As of `June 21, 2025`, it looks like this:
![haii :3](./Pictures/img.png)

## What's missing?
A lot of things I would like to add are missing. Here's a small list of what I could add next.
- [ ] Actual working graphics drivers (blender runs so slow...)
- [ ] Disko for declarative disk management
- [ ] BTRFS for the main drive
- [ ] Go full terminal oriented
- [ ] Bring all of my dotfiles into here
