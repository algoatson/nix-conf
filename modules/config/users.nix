{ config, lib, pkgs, ... }:

{
  users.users.notrazor = {
    isNormalUser = true;
    description = "notrazor";
    extraGroups = [ "networkmanager" "wheel" "wireshark" "docker" "libvirtd" ];
    packages = with pkgs; [
      wine64
      wine
      # Shells
      zsh
      zsh-completions
      zsh-clipboard
      zsh-autocomplete
      zsh-autosuggestions
      zsh-syntax-highlighting
      zsh-history
      zsh-z
      oh-my-zsh
      element-desktop
      rustc rustfmt
      cargo
      nix-zsh-completions
      fish
      # Terminal Emulators
      kitty
      tmux
      alacritty
      terminator
      # Browsers
      firefox
      qutebrowser
      tor-browser-bundle-bin
      google-chrome
      # Social Media
      discord
      element
      # qtox
      # File Managers
      # Password Managers
      keepassxc
      # Note-Taking Software
      obsidian
      # Code Editors
      vscode
      emacs
      # Cryptocurrency
      monero-gui
      # Reverse Engineering / Exploitation / Debugging
      elfcat
      yasm
      radare2
      ghidra
      gdb
      # Pentesting
      burpsuite
      wfuzz
      metasploit
      pwncat
      # Forensics
      volatility3
      # Networking
      wireshark
      tshark
      tcpdump
      httping
      dig
      # Virtualization
      qemu # virtualbox # vmware-workstation
      # IRC
      irssi
      # Programming
      cmake
      gcc-arm-embedded
      doxygen
      php
      openssl
      openssl.dev
      gitkraken
      gnumake
      man-db
      man-pages
      qtcreator
      qt6.full
      qt6.qtbase
      slack
      slack-term
      pe-bear
      git-credential-manager
      # Databases
      mariadb
      # Wordlists
      crunch
      cewl
      # Fonts
      font-awesome
      font-awesome_5
      font-awesome_4
      bront_fonts
      ucs-fonts
      open-sans
      zilla-slab
      roboto-serif
      roboto-mono
      roboto
      noto-fonts
      dejavu_fonts
      nerdfonts
      font-manager
      # Games
      steam
      protontricks
      superTux
      superTuxKart
      # Torrenting
      qbittorrent
      # Multimedia Streaming Platform
      plex
      # Audio
      pulseeffects-legacy
      # Others
      asciinema
      flameshot
      nautilus
      libsForQt5.okular
      ffmpeg-full
      bat
      p7zip
      vlc
      libreoffice
      yad
      openrgb-with-all-plugins
      i2c-tools
      phinger-cursors
      lxappearance
      bibata-cursors
      rofi
      bc
      bison
      binutils
      flex
      libelf
      libelfin
      elfio
      cpio
      groff
      gtk2
      gtk3
      gtk4
      z3
      drawio
      debootstrap
      pcsclite
      haskellPackages.haskell-language-server
      texliveFull
      mesa
      pkg-config
      hashcat
      hcxtools
      pavucontrol
      eza
      ripgrep
      tabnine
      xclip
      bitcoin
      weechat
      lutris
      mullvad-vpn
      aircrack-ng
      powershell
      ollama
      telegram-desktop
      fzf
      popcorntime
      dunst
      libnotify
      openvr
      quickemu
      nbd
      parted
      ntfs3g
      hexedit
      socat
      jellyfin
      bridge-utils
      gns3-gui
      virt-manager
      gns3-server
      glib
      librewolf-unwrapped
      clang_18 clang-tools ltex-ls zathura
      ctags codeium efm-langserver # lldb_12
      nerdfonts fd linuxHeaders latexrun

    ];
    shell = pkgs.fish;
  };
}
