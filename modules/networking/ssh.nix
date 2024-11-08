{ pkgs, ... }:

{
  services.openssh.enable = true;
  services.fail2ban.enable = true;

  environment.systemPackages = with pkgs; [
    openssh
    fail2ban
  ];
}
