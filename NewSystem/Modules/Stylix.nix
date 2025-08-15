{ ... }:

let
  random-wallpapers = {
    nix = builtins.fetchurl {
      url =
        "raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/refs/heads/main/os/nix-black-4k.png";
      sha256 = "144mz3nf6mwq7pmbmd3s9xq7rx2sildngpxxj5vhwz76l1w5h5hx";
    };
    line_icons = builtins.fetchurl {
      url =
        "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/refs/heads/main/patterns/line_icons.png";
      sha256 = "1rf3pi7gap2233kdlly1wbqi889pyj241v9bdb4njbb1akm9n99j";
    };
    mandelbrot_full = builtins.fetchurl {
      url =
        "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/refs/heads/main/mandelbrot/mandelbrot_full_blue.png";
      sha256 = "0jvp5azla3qhld9n6xjbbyhz6x6w1m87j3kicgcbbn9nmv6h85ny";
    };
    mandelbrot_gap = builtins.fetchurl {
      url =
        "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/refs/heads/main/mandelbrot/mandelbrot_gap_red.png";
      sha256 = "0mxvzy7bm4sid0nkbfi7ghfvv54v2xzd0dpqxmv7nk69x07vz6mi";
    };
    triangles = builtins.fetchurl {
      url =
        "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/refs/heads/main/minimalistic/catppuccin_triangle.png";
      sha256 = "1pfszdksk89pyl2jkgh20lfcwyh1lh961bkri7n49ix1dagvh3yr";
    };
    cat = builtins.fetchurl {
      url =
        "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/refs/heads/main/minimalistic/dark-cat-rosewater.png";
      sha256 = "1bif87s8cxlg4k58yj5816v174vqbn4p4fqlzv2rnhj69jszpy0z";
    };
    hashtags = builtins.fetchurl {
      url =
        "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/refs/heads/main/minimalistic/hashtags-black.png";
      sha256 = "03y4rmmjv1qllvm8nrbgjpx563vnvj337i9kbkf2jaxvcl1lj12p";
    };
    rhombus = builtins.fetchurl {
      url =
        "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/refs/heads/main/minimalistic/romb.png";
      sha256 = "1pdfd0gr718c5ja4apfawl6pa4vi3wga0agf4xmh3c85r4spn8xs";
    };
    tetris = builtins.fetchurl {
      url =
        "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/refs/heads/main/minimalistic/tetris.png";
      sha256 = "16dfxxn77fymb44daadd85ck0l98zvmyq6lg9l04ip0dsirzmxkc";
    };
    pacman = builtins.fetchurl {
      url =
        "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/refs/heads/main/misc/cat_pacman.png";
      sha256 = "16n3azhmqqjgj4jmsf0g0v3v0zmgh8kll876c17an95pqah2hlsr";
    };
    waves = builtins.fetchurl {
      url =
        "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/refs/heads/main/waves/cat-waves.png";
      sha256 = "0mrzcy7v2hz08iwhbjbjh32f8n4ss1a717v62ys23hf6mxs61k7k";
    };
  };
  base16-theme = builtins.fetchurl { # Catppuccin
    url =
      "https://raw.githubusercontent.com/catppuccin/base16/refs/heads/main/base16/macchiato.yaml";
    sha256 = "1wxws344d1m5svwc0gzbfxg5vjb16smpsdi28j25h7c4fz36kdwz";
  };
in {
  # Stylix
  stylix = {
    enable = true;
    autoEnable = true;
    image = random-wallpapers.mandelbrot_full;
    base16Scheme = base16-theme;
    polarity = "dark";
  };
}
