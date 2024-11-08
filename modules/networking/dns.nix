{ pkgs, ... }:

{
  networking.nameservers = [ "10.0.0.69" "127.0.0.1" ];
  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      ipv6_servers = true;
      require_dnssec = true;

      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
      };

      # You can choose a specific set of servers from https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
      server_names = [ "mullvad-adblock-doh" "mullvad-doh" ];
    };
  };

  systemd.services.dnscrypt-proxy2.serviceConfig = {
    StateDirectory = "dnscrypt-proxy";
  };

  environment.systemPackages = with pkgs; [
    dnscrypt-proxy
    dnschef
    aiodnsbrute
    amass
    bind
    dnsenum
    dnsmon-go
    dnsmonster
    dnsrecon
    dnstake
    dnstracer
    dnstwist
    dnspeep
    dnsx
    fierce
    findomain
    knockpy
    subfinder
    subzerod
    wtfis
  ];
}
