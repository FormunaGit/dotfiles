# My Linux Dotfiles
These are my dotfiles that I use on the daily. I like using dotfiles.

## How do I manage my dotfiles?
Personally, I use Home Manager, which uses the Nix language to declaratively manage my dotfiles.

For the "uploading to Git" side of things, I use [LazyGit](https://github.com/jesseduffield/lazygit), a really nice Git client that uses the terminal to manage your Git repositories. I also use the [GitHub CLI](https://github.com/cli/cli) tool to actually add this repository as a remote.

## How do I install these dotfiles?
As said before, the dotfiles are managed in Home Manager/Nix. If you use NixOS, just install Home Manager, put this dotfiles folder in `~/.config/home-manager/`, and run `home-manager switch`.

For non-NixOS users, it's *technically possible* to install the dotfiles manually, but I don't recommend it. Instead, just install Nix and Home Manager and follow the NixOS instructions above. This not only makes sure you don't get into dependency hell, but also you don't trash your home folder with random files, making cleaning up your computer easier.

## How does this look like?
![this is a screenshot of the dotfiles postinstalation also hi what are you doing here?](https://github.com/FormunaGit/dotfiles/blob/main/Images/screenshot-1.png?raw=true)