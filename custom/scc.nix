{ pkgs ? import <nixpkgs> { system = builtins.currentSystem; },
  lib ? pkgs.lib, 
  buildFHSEnv ? pkgs.buildFHSEnv, 
  writeScript ? pkgs.writeScript
}:

buildFHSEnv {
  name = "scc";
  targetPkgs = pkgs: with pkgs; [
    dbus
    fontconfig
    freetype
    libGL
    libxkbcommon
    python38
    xorg.libX11
    xorg.libxcb
    xorg.xcbutilimage
    xorg.xcbutilkeysyms
    xorg.xcbutilrenderutil
    xorg.xcbutilwm
    wayland
    zlib
  ];
  runScript = writeScript "scc.sh" ''
    set -e
    exec "/opt/binaryninja/plugins/scc"
  '';
  meta = {
    description = "scc - shellcode compiler";
    platforms = [ "x86_64-linux" ];
  };
}
