{ pkgs, ... }:
{

  imports = [
    ./fetchers.nix
    ./printing.nix
    ./malware.nix
    ./password.nix
    ./z3.nix
  ];

  environment.systemPackages = with pkgs; [
    noti
    progress
    topgrade
    uget gabutdm
    vulkan-tools
    vulkan-headers
    appimage-run
  ];

}
