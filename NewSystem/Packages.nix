{ pkgs, inputs, ... }: {
  environment.systemPackages = with pkgs; [
    # Main stuff
    wl-clipboard # Wayland clipboard support
    brightnessctl # Brightness control
    kdePackages.kate # Small KDE text editor.
    pavucontrol # Tool for controlling PulseAudio
    kdePackages.kdenlive # Cool open-source video editor
    libnotify # CLI for notifications
    kitty # TODO: Replace this with Ghostty.
    neo-cowsay # Faster Cowsay
    dotacat # Faster Lolcat
    watershot # Screenshotting tool, replacement to Grimblast
    goofcord # Discord 3rd-party client
    legcord # Discord 3rd-party client
    activate-linux # :troll:
    networkmanagerapplet # Tray item for controlling Wi-Fi.
    blender # 3D modelling software
    mission-center # Windows Task Manager
    inotify-tools # File change watcher, used in AGS
    system-config-printer # GUI printer manager.
    pamixer # CLI for managing PulseAudio
    dart-sass # LSP for SCSS
    krita # Cool drawing program
    riseup-vpn # Free VPN
    playerctl # CLI for controlling music
    wget # No idea why this doesn't come by default.
    qemu # QEMU.
    age
    sops # Age and Sops! Used with Sops-nix.
    motrix # Download manager
    git
    gh # Git and the GitHub CLI!
    ydotool # Automation tool
    nodejs # I don't like JS, buuuut...
    ripgrep # Faster version of GNU grep
    unzip
    unrar # Unzip and Unrar command.
    fastfetch # Faster Neofetch
    wofi # App launcher
    mangohud # Resource overlay for games
    firefox # TODO: Replace with Floorp.
    neovim # Terminal Editor
    moonlight-qt # Sunshine client
    beeper # Universal chat app. What more could I want?
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
    rustup # Rust toolchain installer.
    gcc # GNU's C compiler.
    godot_4 # Best game engine!
    gitkraken # Closed-source GUI for Git. TODO: Start using Magit.
    nixd # Cool Nix LSP.
    nixfmt-classic # Cool Nix file formatter.
    vscodium-fhs # FOSS Code editor
    inputs.ignis.packages.${system}.ignis # Ignis
    black # Python file formatter
  ];
}
