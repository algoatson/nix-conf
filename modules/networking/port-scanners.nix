{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    arp-scan
    das
    ipscan
    masscan
    naabu
    nmap
    udpx
    sx-go
    rustscan
    zmap
  ];
}
