{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # ida-free -- broken
    ghidra
    radare2
  ];

}
