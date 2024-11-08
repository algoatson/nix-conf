{ pkgs, ... }:

{
  services.mullvad-vpn.enable = true;

  environment.systemPackages = with pkgs; [
    openvpn
    mullvad-vpn
    mullvad-closest
    mullvad-browser
  ];
}
