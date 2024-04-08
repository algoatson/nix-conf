# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/config/users.nix
      ./modules/apps/vim
      ./modules/security
      ./modules/WM/xmonad
      # ./modules/gnome.nix
      # ./modules/xfce.nix
      # ./editors/emacs.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sdb";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.nameservers = [ "127.0.0.1" "10.0.0.69" ];
  networking.resolvconf.enable = false;
  boot.kernelPackages = pkgs.linuxPackages_6_5; # pkgs.linuxPackages_latest; (cannot use latest yet)
  boot.extraModulePackages = with config.boot.kernelPackages; [
    rtl8812au
  ];
  boot.initrd.kernelModules = [ "8812au" ];

  boot.kernel.sysctl = {
    "kernel.core_pattern" = "core";
  };

  powerManagement.cpuFreqGovernor = "performance";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Enable the GNOME Desktop Environment. (SKIP)
  services.xserver.displayManager.gdm.enable = false;
  services.xserver.desktopManager.gnome.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.plex = {
    enable = true;
    openFirewall = true;
  };

  services.picom.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  # programs.gnupg.agent.enable = true;
  # programs.gnupg.agent.pinentryFlavor = "gnome3";
  programs.fish.enable = true;
  programs.wireshark.enable = true;
  programs.steam.enable = true;

  nixpkgs.config.allowUnfree = true;

  # only works on 23.11
  fonts = {
    packages = with pkgs; [ (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) inter noto-fonts noto-fonts-emoji font-awesome ];
    fontconfig = {
      defaultFonts = rec {
        monospace = [ "JetBrainsMono Nerd Font" "Noto Sans Mono" ];
        sansSerif = [ "Inter" "Noto Sans" "Noto Sans Japanese" "Noto Sans Korean" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

  # Allow unfree packages
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     wget openssh most
     moc qalculate-gtk
     gimp
     zip unzip
     tor torsocks
     thunderbird
     vesktop
     alacritty
     neofetch
     htop
     btop
     openvpn
     asciinema
     xmonad-with-packages nitrogen picom dmenu polybar
     tmux nodejs
     universal-ctags
     breeze-icons
     gcc dbus stdenv
     python311 linuxHeaders
     tldr xorg.xinit xorg.xrdb
     (python311.withPackages(ps: with ps; [ angr pypresence pip pwntools matplotlib pandas numpy pyyaml coloredlogs pypresence rpyc]))
   ];

  environment.variables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {

  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services.dnscrypt-proxy2.enable = true;
  # services.dnscrypt-wrapper.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.pcscd.enable = true;

  services.tor.enable = true;

  # services.lxdm.enable = true;
  # Open ports in the firewall.
  networking = {
    extraHosts = ''
      # extraHosts
    '';
  };

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  virtualisation.docker.enable = true;
  users.extraGroups.vboxusers.members = [ "notrazor" ];
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
