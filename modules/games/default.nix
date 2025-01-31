{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    atlauncher moonlight-qt
  ];
}
