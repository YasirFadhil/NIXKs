{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
  # Core System Utilities
    # displaycal
    # argyllcms
    # colord
    wget
    curl
    git
    udisks
    efibootmgr
    dbus
    gvfs
    mediawriter
    lm_sensors
    polkit_gnome
    gnome-keyring
    upower
    linuxPackages.cpupower
    xwayland-satellite

    # Audio/Video System
    alsa-utils
    alsa-ucm-conf
    alsa-tools
    pamixer
    playerctl
    ffmpeg_7

    # Development Tools (System-wide)
    python3
    qt6.qtbase
    qt6.qtdeclarative
    qt6.qttools
    qt6.qmake
    android-tools
    bun

    # Shells
    nushell
    starship
    zsh

    # GNOME/GTK System Libraries
    gnome-disk-utility
    librsvg
    gtk3
    gtk4
    gtk-layer-shell

    # GTK Themes and Icons (System-wide)
    whitesur-gtk-theme
    whitesur-icon-theme
    bibata-cursors

    # Display Servers & Protocols
    spice-gtk
    wayland-utils
    wayland-protocols
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
    xdg-desktop-portal-hyprland
    xwayland
    xhost
    xauth

    # Network Utilities
    samba
    cifs-utils
    networkmanagerapplet

    # Qt Configuration (System-wide)
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    libsForQt5.qtstyleplugin-kvantum
    sddm-astronaut

    # Screenshot Tools
    grim
    slurp

    # Clipboard
    cliphist

    # System Control
    brightnessctl
  ];
  
  environment.cosmic.excludePackages = with pkgs; [
    cosmic-edit
  ];

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    epiphany
    geary
    evince
  ];

  system.userActivationScripts = {
    copy-fonts-local-share = {
      text = ''
        chmod -R u+w ~/.local/share/fonts 2>/dev/null || true
        rm -rf ~/.local/share/fonts
        mkdir -p ~/.local/share/fonts
        cp ${pkgs.corefonts}/share/fonts/truetype/* ~/.local/share/fonts/
        chmod 755 ~/.local/share/fonts
        chmod 644 ~/.local/share/fonts/*
      '';
    };
  };
}
