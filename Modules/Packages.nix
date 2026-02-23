{ pkgs, inputs, ... }:
let
  hyprcapCode = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/alonso-herreros/hyprcap/refs/heads/main/hyprcap";
  };
in
{
  environment.systemPackages = with pkgs; [
    # Main stuff
    wl-clipboard # Wayland clipboard support
    kdePackages.kdenlive # Cool open-source video editor
    libnotify # CLI for notifications
    neo-cowsay # Faster Cowsay
    dotacat # Faster Lolcat
    legcord # Discord 3rd-party client
    blender # 3D modelling software
    mission-center # Windows Task Manager
    wget # No idea why this doesn't come by default.
    qemu # QEMU.
    age # Age and Sops!
    sops # Used with Sops-nix.
    motrix # Download manager
    git # Git and...
    gh # ...the GitHub CLI!
    ydotool # Automation tool
    nodejs # Chaotic neutral.
    ripgrep # Faster version of GNU grep
    unzip # Unzip and...
    unrar # ...Unrar command.
    fastfetch # Faster Neofetch
    mangohud # Resource overlay for games
    firefox # TODO: Replace with Floorp.
    nh # A Nix helper.
    kando # Neat pie launcher
    ffmpeg # For converting media types
    yt-dlp # Youtube video downloader
    kitty # Terminal
    swaynotificationcenter # Notification center
    cliphist # Clipboard history manager
    superfile # TUI file manager
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
    # ╔────────────╗ #
    # │Gaming Stuff│ #
    # ╚────────────╝ #
    wineWowPackages.stable # Windows app compatibility layer with 64-bit support.
    prismlauncher # Custom launcher for Minecraft.
    winetricks # GUI for managing Wine prefixes.
    r2modman # Mod manager for Unity-based games.
    lutris-unwrapped # Game launcher
    inputs.amprPackages.packages.${system}.classicube
    # ╔───────────╗ #
    # │Development│ #
    # ╚───────────╝ #
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
