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
    nodejs # I don't like JS, buuuut...
    ripgrep # Faster version of GNU grep
    unzip
    unrar # Unzip and Unrar command.
    fastfetch # Faster Neofetch
    mangohud # Resource overlay for games
    firefox # TODO: Replace with Floorp.
    #neovim # Terminal Editor
    beeper # Universal chat app. What more could I want?
    nh # A Nix helper.
    mumble # Mumble Client
    gnome-tweaks # Tweaks Gnome.
    comma # Cool tool for Nix
    kando # Neat Pie launcher
    ffmpeg # Audio.
    yt-dlp # Youtube video downloader
    fd # Find tool
    gnumake # Make command
    # ╔────────────╗ #
    # │Gaming Stuff│ #
    # ╚────────────╝ #
    wineWowPackages.stable # Windows app compatibility layer with 64-bit support.
    prismlauncher # Custom launcher for Minecraft.
    winetricks # GUI for managing Wine prefixes.
    r2modman # Mod manager for Unity-based games.
    # ╔───────────╗ #
    # │Development│ #
    # ╚───────────╝ #
    nerd-fonts.jetbrains-mono # Awesome font for coding.
    monaspace # Awesome font for coding.
    rustup # Rust toolchain installer.
    gcc # GNU's C compiler.
    gitkraken # Closed-source GUI for Git.
    nixd # Cool Nix LSP.
    nixfmt-classic # Cool Nix file formatter.
    vscodium # FOSS Code editor
    zed-editor # It's back...
    #inputs.ignis.packages.${system}.ignis # Ignis
    black # Python file formatter
    dconf2nix # GNOME config to Nix tool for declarative GNOMing.
    neovide # GUI Neovim
    cachix # Cachix
  ];
}
