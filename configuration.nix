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
    protonup-ng
    protonup-qt
    protonplus
  (python311.withPackages (ps: with ps; [ pypresence pip pwntools matplotlib pandas numpy pyyaml coloredlogs pypresence rpyc ]))
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
  # set -as terminal-features ",*:RGB"
  set -ag terminal-overrides ",tmux-256color:RGB"
  set-option -g allow-passthrough on
  set -g default-terminal "tmux-256color"
  # Fix Colors
  # set -g default-terminal "screen-256color"
  # set -as terminal-features ",xterm-256color:RGB"
  # set-option -g allow-passthrough on
  # set -g status-bg default
  # set -g status-fg pink

  # Scrolling
  setw -g mouse on

  # Start windows and panes at 1, not 0
  # set -g base-index 1
  # setw -g pane-base-index 1

  # Renumber windows
  # set-option -g renumber-windows on

  # Statusline Colors
  # set -g status-style bg=terminal,fg=terminal

  # Statusline location
  # set -g status-position bottom

  # Current window name bold
  # set -g window-status-current-style fg=terminal,bold

  # Time settings
  # set -g status-right "%I:%M %p, %d-%b-%y, %a"
  set  -g history-limit     20000

  # TokyoNight colors for Tmux

  set -g mode-style "fg=#7aa2f7,bg=#3b4261"

  set -g message-style "fg=#7aa2f7,bg=#3b4261"
  set -g message-command-style "fg=#7aa2f7,bg=#3b4261"

  set -g pane-border-style "fg=#3b4261"
  set -g pane-active-border-style "fg=#7aa2f7"

  set -g status "on"
  set -g status-justify "left"

  set -g status-style "fg=#7aa2f7,bg=#16161e"

  set -g status-left-length "100"
  set -g status-right-length "100"

  set -g status-left-style NONE
  set -g status-right-style NONE

  set -g status-left "#[fg=#15161e,bg=#7aa2f7,bold] #S #[fg=#7aa2f7,bg=#16161e,nobold,nounderscore,noitalics]"
  set -g status-right "#[fg=#16161e,bg=#16161e,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#16161e] #{prefix_highlight} #[fg=#3b4261,bg=#16161e,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261] %Y-%m-%d  %I:%M %p #[fg=#7aa2f7,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#15161e,bg=#7aa2f7,bold] #h "
  if-shell '[ "$(tmux show-option -gqv "clock-mode-style")" == "24" ]' {
    set -g status-right "#[fg=#16161e,bg=#16161e,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#16161e] #{prefix_highlight} #[fg=#3b4261,bg=#16161e,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261] %Y-%m-%d  %H:%M #[fg=#7aa2f7,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#15161e,bg=#7aa2f7,bold] #h "
  }

  setw -g window-status-activity-style "underscore,fg=#a9b1d6,bg=#16161e"
  setw -g window-status-separator ""
  setw -g window-status-style "NONE,fg=#a9b1d6,bg=#16161e"
  setw -g window-status-format "#[fg=#16161e,bg=#16161e,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#16161e,bg=#16161e,nobold,nounderscore,noitalics]"
  setw -g window-status-current-format "#[fg=#16161e,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261,bold] #I  #W #F #[fg=#3b4261,bg=#16161e,nobold,nounderscore,noitalics]"

  # tmux-plugins/tmux-prefix-highlight support
  set -g @prefix_highlight_output_prefix "#[fg=#e0af68]#[bg=#16161e]#[fg=#16161e]#[bg=#e0af68]"
  set -g @prefix_highlight_output_suffix ""

  '';

  programs.tmux.terminal = "tmux-256color";
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
