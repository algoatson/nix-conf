{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
    # videoDrivers = ["nouveau"];
    layout = "us";
    xkbVariant = "";

    windowManager = {
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
        enableConfiguredRecompile = true;
        config = builtins.readFile ./xmonad.hs;
        extraPackages = haskellPackages: [
          haskellPackages.dbus
          haskellPackages.List
          haskellPackages.monad-logger
        ];
      };
    };
  };
}
