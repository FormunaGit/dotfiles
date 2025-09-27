{ pkgs, ... }: {
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
    krita # Cool drawing program
    wget # No idea why this doesn't come by default.
    qemu # QEMU.
    age # Age and Sops!
    sops # Used with Sops-nix.
    motrix # Download manager
    git # Git and...
    gh # the GitHub CLI!
    ydotool # Automation tool
    nodejs # I like JS
    ripgrep # Faster version of GNU grep
    unzip
    unrar # Unzip and Unrar command.
    fastfetch # Faster Neofetch
    mangohud # Resource overlay for games
    firefox # TODO: Replace with Floorp.
    nh # A Nix helper.
    mumble # Mumble Client
    gnome-tweaks # Tweaks Gnome.
    kando # Neat Pie launcher
    ffmpeg # Audio.
    yt-dlp # Youtube video downloader
    kitty # Terminal
    tmux # Running Nix-Shell to get this is getting annoying.
    swaynotificationcenter # Notification center
    cliphist # Clipboard history manager
    superfile # TUI file manager
    virt-manager # Virtualization manager
    openrazer-daemon # Daemon for OpenRazer devices
    polychromatic # GUI for OpenRazer devices
    nicotine-plus # Client for Soulseek network
    hyprpaper # Wallpaper manager for Hyprland
    hyprshot # Screenshot tool for Hyprland
    # ╔────────────╗ #
    # │Gaming Stuff│ #
    # ╚────────────╝ #
    wineWowPackages.stable # Windows app compatibility layer with 64-bit support.
    prismlauncher # Custom launcher for Minecraft.
    winetricks # GUI for managing Wine prefixes.
    r2modman # Mod manager for Unity-based games.
    lutris-unwrapped # Game launcher
    # ╔───────────╗ #
    # │Development│ #
    # ╚───────────╝ #
    bun # JavaScript runtime
    nerd-fonts.jetbrains-mono # Awesome font for coding.
    monaspace # Awesome font for coding.
    rustup # Rust toolchain installer.
    gcc # GNU's C compiler.
    gitkraken # Closed-source GUI for Git.
    nixd # Cool Nix LSP.
    nixfmt-classic # Cool Nix file formatter.
    zed-editor # It's back...
    black # Python file formatter
    neovim # CLI Neovim
    neovide # GUI Neovim
    cachix # Cachix
    #inputs.ignis.packages.${system}.ignis
    playerctl # Control playing media
    kdePackages.xwaylandvideobridge # Allow sharing Wayland windows in XWayland
    rofi # Launcher
    wireguard-tools # Wireguard tools
    go # Golang
    packwiz # CLI tool for Minecraft modpack development
    pipx # Install and run Python applications in isolated environments
    hyprls # Hyprland LSP
  ];
}
