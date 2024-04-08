{ pkgs ? import <nixpkgs> { system = builtins.currentSystem; },
  lib ? pkgs.lib,
  buildFHSEnv ? pkgs.buildFHSEnv,
  writeScript ? pkgs.writeScript
}:

buildFHSEnv {
  name = "binaryninja-dev";
  targetPkgs = pkgs: with pkgs; [
    dbus
    fontconfig
    freetype
    libGL
    libxkbcommon
    python311
    (python311.withPackages(ps: with ps; [
      angr pypresence numpy pygments requests
      networkx intervaltree sentence-transformers
      scikit-learn markdown watchdog numpy
      pydantic
    ]))
    xorg.libX11
    xorg.libxcb
    xorg.xcbutilimage
    xorg.xcbutilkeysyms
    xorg.xcbutilrenderutil
    xorg.xcbutilwm
    wayland
    zlib
    gdb
  ];
  runScript = writeScript "binaryninja.sh" ''
    set -e
    exec "/opt/binaryninja-dev/binaryninja"
  '';
  meta = {
    description = "BinaryNinja";
    platforms = [ "x86_64-linux" ];
  };
}
