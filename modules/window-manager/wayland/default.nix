{ config, pkgs, ... }:

{
  programs.xwayland.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  environment.systemPackages = with pkgs; [
    pyprland
    hyprpicker
    hyprcursor
    hyprlock
    hypridle
    hyprpaper

    wezterm
    cool-retro-term

    starship
    helix

    mpv
    imv
  ];

  # wayland.windowManager.hyprland.settings = builtins.readFile ./hyprland.conf;
}
