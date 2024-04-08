{ config, lib, pkgs, ... }:

{
  users.users.notrazor = {
    isNormalUser = true;
    description = "notrazor";
    extraGroups = [ "networkmanager" "wheel" "wireshark" "docker" ];
    packages = with pkgs; [
      # Shells
      zsh zsh-completions zsh-clipboard zsh-autocomplete zsh-autosuggestions zsh-syntax-highlighting zsh-history zsh-z oh-my-zsh nix-zsh-completions
      fish
      # Terminal Emulators
      kitty tmux alacritty terminator
      # Browsers
      firefox qutebrowser tor-browser-bundle-bin google-chrome
      # Social Media
      discord element qtox
      # File Managers
      gnome.nautilus
      # Password Managers
      keepassxc
      # Note-Taking Softwares
      obsidian
      # Code Editors
      vscode emacs
      # Cryptocurrency
      monero-gui
      # Reverse Engineering / Exploitation / Debugging
      elfcat yasm radare2 ghidra gdb
      # Pentesting
      burpsuite wfuzz metasploit pwncat
      # Forensics
      volatility3
      # Networking
      wireshark tshark tcpdump bettercap dnschef yersinia httping dig
      # Virtualization
      virtualbox vmware-workstation qemu
      # IRC
      irssi
      # Programming
      cargo cmake gcc-arm-embedded doxygen php rustc openssl openssl.dev gitkraken gnumake man-db man-pages qtcreator qt6.full qt6.qtbase
      slack slack-term pe-bear git-credential-manager
      # Databases
      mysql
      # Wordlists
      crunch cewl
      # Fonts
      font-awesome font-awesome_5 font-awesome_4 bront_fonts ucs-fonts open-sans zilla-slab roboto-serif roboto-mono roboto noto-fonts dejavu_fonts nerdfonts
      font-manager
      # Games
      steam protontricks superTux superTuxKart
      # Docker
      docker
      # Torrenting
      qbittorrent
      # Multimedia Streaming Platform
      plex
      # Audio
      pulseeffects-legacy
      # Others
      asciinema flameshot gnome.nautilus libsForQt5.okular ffmpeg-full bat
      p7zip vlc libreoffice cargo yad openrgb-with-all-plugins i2c-tools
      phinger-cursors lxappearance bibata-cursors rofi bc bison binutils flex
      libelf libelfin elfio cpio busybox groff gtk4 drawio debootstrap pcsclite
      haskellPackages.haskell-language-server texliveFull mesa emacs-all-the-icons-fonts
      pkg-config hashcat hcxtools pavucontrol dnscrypt-proxy
     ];
     shell = pkgs.fish;
  };
}
