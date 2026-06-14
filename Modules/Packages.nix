{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    libnotify # CLI for notifications
    wget # No idea why this doesn't come by default.
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
    btop # System monitor
    eza # Alternative to ls
    zoxide # Alternative to cd
    playerctl # Control playing media
    trashy # Alternative to rm
    gimp # GIMP image editor
    obsidian # Obsidian note-taking app
    # ╔────────────╗ #
    # │Gaming Stuff│ #
    # ╚────────────╝ #
    wineWow64Packages.stable # Windows app compatibility layer with 64-bit support.
    winetricks # GUI for managing Wine prefixes.
    r2modman # Mod manager for Unity-based games.
    # ╔───────────╗ #
    # │Development│ #
    # ╚───────────╝ #
    zed-editor # Zed editor
    rustup # Rust
    gcc # for Rust C linker
    neovim # Nvim
    nil # Nix LSP
    nixfmt # Nix file formatter
    black # Python file formatter
    wireguard-tools # Wireguard tools
    packwiz # CLI tool for Minecraft modpack development
    gitkraken # GUI for Git
    cloudflared # Cloudflare client
    distrobox # Aughhh
    android-tools # For ADB
    poetry # Python management
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.monaspace # Awesome font for coding.
  ];
}
