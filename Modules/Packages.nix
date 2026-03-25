{ pkgs, inputs, ... }:
let
  hyprcapCode = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/alonso-herreros/hyprcap/refs/heads/main/hyprcap";
    sha256 = "0xbcdvkjbpywwf65kvb8jbrls1r8hnhdvgq8q65vxgbg9z6qcxyl";
  };
in
{
  environment.systemPackages = with pkgs; [
    # Main stuff
    wl-clipboard # Wayland clipboard support
    libnotify # CLI for notifications
    legcord # Discord 3rd-party client
    blender # 3D modelling software
    mission-center # Windows Task Manager
    wget # No idea why this doesn't come by default.
    qemu # QEMU.
    age # Age and Sops!
    sops # Used with Sops-nix.
    git # Git and...
    gh # ...the GitHub CLI!
    ydotool # Automation tool
    ripgrep # Faster version of GNU grep
    unzip # Unzip and...
    unrar # ...Unrar command.
    fastfetch # Faster Neofetch
    firefox # TODO: Replace with Floorp.
    nh # A Nix helper.
    ffmpeg # For converting media types
    yt-dlp # Youtube video downloader
    kitty # Terminal
    cliphist # Clipboard history manager
    virt-manager # Virtualization manager
    openrazer-daemon # Daemon for OpenRazer devices
    polychromatic # GUI for OpenRazer devices
    (pkgs.writeShellScriptBin "hyprcap" (builtins.readFile hyprcapCode)) # Better screenshot tool for Hyprland
    slurp # Needed for Hyprcap
    grim # Needed for Hyprcap
    hyprpicker # Needed for Hyprcap
    waybar # Status bar for Wayland
    btop # System monitor
    eza # Alternative to ls
    zoxide # Alternative to cd
    playerctl # Control playing media
    trashy # Alternative to rm
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default # Noctalia shell!
    (pkgs.gimp-with-plugins.override {
      plugins = with pkgs.gimpPlugins; [
        gmic
      ];
    })
    # ╔────────────╗ #
    # │Gaming Stuff│ #
    # ╚────────────╝ #
    wineWow64Packages.stable # Windows app compatibility layer with 64-bit support.
    winetricks # GUI for managing Wine prefixes.
    r2modman # Mod manager for Unity-based games.
    lutris-unwrapped # Game launcher
    #inputs.amprPackages.packages.${system}.classicube
    # ╔───────────╗ #
    # │Development│ #
    # ╚───────────╝ #
    zed-editor # Zed editor
    rustup # Rust
    gcc # for Rust C linker
    nil # Nix LSP
    nixfmt # Nix file formatter
    black # Python file formatter
    rofi # Launcher
    wireguard-tools # Wireguard tools
    go # Golang
    packwiz # CLI tool for Minecraft modpack development
    hyprls # Hyprland LSP
    lazygit # TUI for Git
    lune # Luau runtime
    stylua # Lua(u) code formatter
    cloudflared # Cloudflare client
    distrobox # Aughhh
    android-tools # For ADB
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.monaspace # Awesome font for coding.
  ];
}
