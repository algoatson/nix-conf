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
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/bootloader
      ./modules/kernel
      ./modules/localization
      ./modules/config
      # ./modules/apps/vim -- old vim configuration
      ./modules/security
      ./modules/window-manager/xmonad
      ./modules/themes
      ./modules/terminal
      ./modules/fonts
      ./modules/networking
      ./modules/virtualisation
      ./modules/gc
      ./modules/auto-upgrade
      ./modules/misc
      ./modules/sounds
      ./modules/ai
      ./modules/messaging
      ./modules/reversing
      ./modules/storage
      ./modules/android
      ./modules/animation
      ./modules/emulator
      ./modules/programming
      # ./modules/editors
      # ./modules/window-manager/wayland
      # ./modules/gnome.nix
      # ./modules/xfce.nix
    ];

  # powerManagement.cpuFreqGovernor = "performance";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Enable the GNOME Desktop Environment. (SKIP)
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # services.displayManager.sddm.enable = true;

  # services.plex = {
  #   enable = true;
  #   openFirewall = true;
  # };

  # services.dunst.enable = true;

  # services.picom.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  # programs.gnupg.agent.enable = true;
  # programs.gnupg.agent.pinentryFlavor = "gnome3";
  programs.fish.enable = true;
  programs.fish.shellAliases = {
    ls = "eza --icons";
    l = "eza -l --icons";
    ll = "eza -ol --icons";
    la = "eza -al --icons";
    lt = "eza -TL2";
    lal = "eza -oal --icons";
  };
  # programs.fish.shellInit = ''
  #   if test "$TERM" = "xterm-kitty"
  #     # kitty +kitten icat ~/.config/neofetch/cute-kitty-resized.png
  #     tmux new-session
  #   else
  #     ~/.config/evangelion.sh
  #   end
  # '';
  # programs.wireshark.enable = true;
  programs.steam.enable = true;

  nixpkgs.config.allowUnfree = true;

  # hardware.bluetooth.enable = true;
  # hardware.bluetooth.powerOnBoot = true;

  # services.blueman.enable = true;

  # Allow unfree packages
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    ytfzf
    input-leap # software-kvm switch
    most
    moc
    qalculate-gtk
    gimp
    zip
    unzip
    thunderbird
    vesktop
    alacritty
    xorg.xcursorgen
    inkscape
    neofetch
    htop
    btop
    asciinema
    xmonad-with-packages
    nitrogen
    libvirt
    picom
    ubridge
    dmenu
    polybarFull
    tmux
    nodejs
    breeze-icons
    gcc_multi
    dbus
    stdenv
    python311
    linuxHeaders
    tldr
    xorg.xinit
    xorg.xrdb
    (python311.withPackages (ps: with ps; [ angr pypresence pip pwntools matplotlib pandas numpy pyyaml coloredlogs pypresence rpyc ]))
  ];

  environment.variables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  environment.localBinInPath = true;

  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal
        pkgs.xdg-desktop-portal-hyprland
      ];
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {

  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.

  # services.ollama.enable = true;

  services.pcscd.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
    "qbittorrent-4.6.4"
  ];

  programs.tmux.enable = true;
  programs.tmux.extraConfig = ''
  set -as terminal-features ",*:RGB"
  set -ag terminal-overrides ",xterm-256color:RGB"
  setw -g mouse on
  set -g status-style bg=#201430,fg=#8edf5f
  set-option -g allow-passthrough on

  '';
  # programs.tmux.terminal = "tmux-256color";
  # programs.tmux.extraConfig = ''
    # set-default colorset-option -ga terminal-overrides ",xterm-256color:Tc"
    # Fix Colors
    # set -g default-terminal "screen-256color"
    # set -as terminal-features ",xterm-256color:RGB"

  #   set -g default-terminal "tmux-256color"
  #   set-option -g allow-passthrough on

    # Scrolling
  #   setw -g mouse on

    # Start windows and panes at 1, not 0
  #   set -g base-index 1
  #   setw -g pane-base-index 1

    # Renumber windows
  #   set-option -g renumber-windows on

    # Statusline Colors
  #   set -g status-style bg=black,fg=white

    # Statusline location
  #   set -g status-position bottom

    # Current window name bold
    # set -g window-status-current-style fg=terminal,bold

    # Time settings
  #   set -g status-right "%I:%M %p, %d-%b-%y, %a"

    # Increase left length
  #   set -g status-left-length 20
  # '';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
