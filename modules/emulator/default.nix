{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ryujinx mgba desmume dolphin-emu antimicrox
    retroarchFull winetricks
  ];
}
