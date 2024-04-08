{ config, lib, ... }:

{
  services.xserver = {
    videoDrivers = ["nvidia"];
    layout = "us";
    xkbVariant = "";
  };

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gnome.enable = true;
}
