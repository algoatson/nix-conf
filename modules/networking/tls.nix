
{ pkgs, ... }:

{
  # SSL/TLS testing tools
  environment.systemPackages = with pkgs; [
    cero
    sslscan
    ssldump
    sslsplit
    sslstrip
    testssl
    tlsx
  ];
}
