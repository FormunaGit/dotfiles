{ pkgs, ... }:
{
  services = {
    cliphist = { # Wayland clipboard manager
      enable = true;
      allowImages = true;
    };
    playerctld = { # Player control daemon
      enable = true;
    };
    mako = { # Notification daemon
      enable = true;
      extraConfig = toString (builtins.readFile ./mako/config);
    };
    trayscale = { # Unofficial GUI for Tailscale
      enable = true;
      hideWindow = true;
    };
  };

  programs = {
    fastfetch = { # Faster recreation of neofetch
      enable = true;
    };
    wofi = { # App launcher
      enable = true;
    };
    #thunderbird = { # Email client
    #  enable = true;
    #};
    # Removed because I don't know what a profile is.
    neovim = { # TUI editor, fork of Vim
      enable = true;
      defaultEditor = true;
      withPython3 = true;
    };
    git = { # The land of the doomed.
      enable = true;
    };
    lazygit = { # A TUI for Git. Makes using git easier when you can't open a code editor.
      enable = true;
    };
  };

  # Apps with no HM configuration
  home.packages = with pkgs; [
    wl-clipboard # For Wayland clipboard support
    motrix # Download manager
    busybox # Some useful tools
    brightnessctl # Brightness control
    nautilus # File manager, TODO: remove this when installing GNOME.
    kdePackages.kate # Text editor, TODO: replace this with something else. probably.
    lutris # Game launcher
    vscodium # Code editor, when JB software can't be used.
    python312 # Python 3.12. duh.
    temurin-jre-bin # Temurin JRE 21
    wineWowPackages.stable # Wine (64/32 bit)
    nerd-fonts.jetbrains-mono # The best font for coding + Nerd Fonts icons!
    nwg-drawer # App launcher. TODO: Setup a nice Wofi theme and remove this.
    nwg-look # GTK theme changer.
    pavucontrol # PulseAudio Volume Control
    obs-studio # Open Broadcaster Software
    kdenlive # Video editor
    r2modman # Mod manager for Unity games
    waypaper # Wallpaper manager (powered by SWWW)
    swww # Wallpaper daemon
    libnotify # Tool for sending notifications to desktop
    prismlauncher # Minecraft custom launcher
    neo-cowsay # "Cowsay reborn", yeah whatever that means.
    dotacat # Faster lolcat
    grimblast # Screenshot tool for Hyprland
    legcord # Discord custom client
    winetricks # Script for making Wine installs easier
    # Was going to add Protontricks here, but there's a spot in programs.steam.
    nodejs # Who brought JavaScript to the server, and why?
    wgcf # Convert Cloudflare's Warp(+) VPN to WireGuard
    networkmanagerapplet # Network manager applet
    jetbrains.webstorm # Jetbrains IDE for the web.
    jetbrains.pycharm-professional # Jetbrains IDE for Python, but professional.
    lmms # Music editor similar to FL Studio but open source.
    blender # 3D modelling software
    mission-center # GNOME resource visualizer (that's a lot of words to say GUI fastfetch), TODO: remove this when installing GNOME.
    inotify-tools # Thingamabob that detects file changes
    nixd # Nix LSP, used for autocompletion
    system-config-printer # GUI printer manager
    gimp # Image editor
    thunderbird # Email client
    gh # GitHub CLI
  ];
}