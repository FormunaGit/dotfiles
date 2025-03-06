{ lib, stdenv, fetchurl, makeWrapper, autoPatchelfHook, xz }:

stdenv.mkDerivation rec {
  pname = "borked3ds";
  version = "2025.02.14";  # Update to latest version if nessecary(?)

  src = fetchurl {
    url = "https://github.com/Borked3DS/Borked3DS/releases/download/v${version}/borked3ds-v${version}-linux-appimage-gcc-24.04.tar.xz";
    sha256 = "sha256-H3vVGwYNDrDAzotngXrPoX7ngp0p8eCE2XePZfCtpKM=";  # Replace with actual hash
  };

  nativeBuildInputs = [ autoPatchelfHook xz makeWrapper ];

  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/bin
    tar -xf $src

    # Move extracted AppImages to bin directory
    cp borked3ds-v${version}-linux-appimage-gcc-24.04/borked3ds.AppImage $TMPDIR/bin/borked3ds
    cp borked3ds-v${version}-linux-appimage-gcc-24.04/borked3ds-cli.AppImage $TMPDIR/bin/borked3ds-cli
    cp borked3ds-v${version}-linux-appimage-gcc-24.04/borked3ds-room.AppImage $TMPDIR/bin/borked3ds-room

    install -m 755 $TMPDIR/borked3ds/borked3ds.AppImage $out/bin/borked3ds
    install -m 755 $TMPDIR/borked3ds/borked3ds-cli.AppImage $out/bin/borked3ds-cli
    install -m 755 $TMPDIR/borked3ds/borked3ds-room.AppImage $out/bin/borked3ds-room

    chmod +x $out/bin/borked3ds $out/bin/borked3ds-cli $out/bin/borked3ds-room
  '';

  meta = with lib; {
    description = "A simple 3DS emulator (AppImage version)";
    homepage = "https://github.com/Borked3DS/Borked3DS";
    license = licenses.gpl2;
    platforms = platforms.linux;
  };
}