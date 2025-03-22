{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vscodium # Code editor when Zed is broken.
    nerd-fonts.jetbrains-mono # My favorite font for coding
    rustup # Rust
    gcc # GNU's C compiler.
    godot_4 # Best game engine!
    gitkraken # I know it's closed source. And I'll keep using it till I find a better one.
    nixd # Useful Nix LSP.
    nixfmt-classic # Nix file formatter
    android-studio # The Android studio.

    ## EMACS PACKAGES! ##
   emacsPackages.command-log-mode
   emacsPackages.evil
   emacsPackages.ivy
   emacsPackages.counsel
   emacsPackages.doom-modeline
   emacsPackages.rainbow-delimiters
   emacsPackages.all-the-icons
   (pkgs.emacsWithPackagesFromUsePackage {
      package = pkgs.emacs30-gtk3;  # replace with pkgs.emacsPgtk, or another version if desired.
      config = ../../Dotfiles/emacs/init.el;
      # config = path/to/your/config.org; # Org-Babel configs also supported

      # Optionally provide extra packages not in the configuration file.
      extraEmacsPackages = epkgs: [
        epkgs.use-package
      ];
   })
];

  nixpkgs.config.android_sdk.accept_license = true; # Accept ASDK's license.

  # Enable Docker
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # Codeium Fix (yes I use AI, get over it.)
  programs.nix-ld.enable = true;

  # Services
  services.openssh.enable = true; # Enables SSH server
}
