{ config, lib, ... }:

{
  services.xserver = {
    videoDrivers = ["nvidia"];
    layout = "us";
    xkbVariant = "";
  };

  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.desktopManager.xfce.enableScreenSaver = true;
  programs.thunar.enable = true;
}
