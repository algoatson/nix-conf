{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    android-studio android-tools
    setools
    dex2jar jadx
    apktool
    aapt
  ];

}
