# My Linux Dotfiles
These are my dotfiles that I use on the daily. I like using dotfiles.

## How do I manage my dotfiles?
Personally, I use GNU Stow, which simply symlinks your dotfiles within your home directory (`~`). If you want to learn how to use Stow, try [this guide](https://www.jakewiesler.com/blog/managing-dotfiles) by Jake Wiesler.

For the "uploading to Git" side of things, I use [LazyGit](https://github.com/jesseduffield/lazygit), a really nice Git client that uses the terminal to manage your Git repositories. I also use the [GitHub CLI](https://github.com/cli/cli) tool to actually add this repository as a remote.

## How do I install these dotfiles?
Currently there is no install script (coming soon :tm: ), so you need to run `stow` followed by the name of the dotfile folder you want.
> NOTE: You *probably* could use `stow *` to install everything swiftly, but that's for another day.

> **TIP: ** For installing the NixOS configuration files, use `sudo stow -t /etc/nixos nixos` to place them in the correct place (after removing the /etc/nixos/ folder ofcourse)
