# #######################
##     Packages.nix    ##
#########################
#  Easy to understand.  #
# Contains every system #
# package.              #
#########################
{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    wl-clipboard # For Wayland clipboard support
    brightnessctl # Brightness control
    kdePackages.kate # Text editor, TODO: replace this with something else. probably.
    nwg-drawer # App launcher. TODO: Setup a nice Wofi theme and remove this.
    nwg-look # GTK theme changer.
    pavucontrol # PulseAudio Volume Control
    obs-studio # Open Broadcaster Software
    kdenlive # Video editor
    r2modman # Mod manager for Unity games
    waypaper # Wallpaper manager (powered by SWWW)
    swww # Wallpaper daemon
    libnotify # Tool for sending notifications to desktop

    neo-cowsay # "Cowsay reborn", yeah whatever that means.
    dotacat # Faster lolcat
    grimblast # Screenshot tool for Hyprland
    goofcord # Discord custom client

    wgcf # Convert Cloudflare's Warp(+) VPN to WireGuard
    networkmanagerapplet # Network manager applet
    jetbrains.webstorm # Jetbrains IDE for the web.
    jetbrains.pycharm-professional # Jetbrains IDE for Python, but professional.
    blender # 3D modelling software
    mission-center # GNOME resource visualizer (that's a lot of words to say GUI fastfetch), TODO: remove this when installing GNOME.
    inotify-tools # Thingamabob that detects file changes
    system-config-printer # GUI printer manager
    gimp # Image editor
    thunderbird # Email client
    pamixer # CLI for managing PulseAudio
    inputs.ags.packages.x86_64-linux.default
    dart-sass
    krita
    riseup-vpn
    qbittorrent-enhanced
    xdg-desktop-portal-hyprland
    playerctl
    wget
    cmake
    qemu
    polychromatic
    age
    sops
    stremio
    gopeed
    bottles
    git
    gh
    jetbrains.pycharm-professional
  ];
}
