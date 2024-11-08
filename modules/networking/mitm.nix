{ pkgs, ... }:

{
  # Proxy tools and for MITM
  environment.systemPackages = with pkgs; [
    bettercap
    burpsuite
    ettercap
    mitmproxy
    mubeng
    proxify
    proxychains
    redsocks
    rshijack
    zap
  ];
}
