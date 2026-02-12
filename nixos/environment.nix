{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
  # Core System Utilities
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
    xwayland-satellite

    # Audio/Video System
    alsa-utils
    alsa-ucm-conf
    pamixer
    playerctl
    ffmpeg_7

    # Development Tools (System-wide)
    python3
    qt6.qtbase
    qt6.qtdeclarative
    qt6.qttools
    qt6.qmake

    # System Monitoring
    btop
    fastfetch
    neofetch

    # Essential Editors
    vim
    neovim

    # Shells
    nushell
    starship

    # GNOME/GTK System Libraries
    gnome-disk-utility
    adwaita-icon-theme
    gsettings-desktop-schemas
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
    xorg.xhost
    xorg.xauth

    # Network Utilities
    samba
    cifs-utils
    networkmanagerapplet

    # Qt Configuration (System-wide)
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    libsForQt5.qtstyleplugin-kvantum

    # Screenshot Tools
    grim
    slurp

    # Clipboard
    cliphist

    # System Control
    brightnessctl
  ];



  system.userActivationScripts = {
    copy-fonts-local-share = {
      text = ''
        rm -rf ~/.local/share/fonts
        mkdir -p ~/.local/share/fonts
        cp ${pkgs.corefonts}/share/fonts/truetype/* ~/.local/share/fonts/
        chmod 544 ~/.local/share/fonts
        chmod 444 ~/.local/share/fonts/*
      '';
    };
  };

  environment.sessionVariables.ALSA_CONFIG_UCM2 = "${pkgs.alsa-ucm-conf}/share/alsa/ucm2";
}
