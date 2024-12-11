{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ida-free
    ghidra
    cutter
    radare2 # r2
    iaito   # gui for radare2
  ];

}
