{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ida-free
    ghidra
    radare2
  ];

}
