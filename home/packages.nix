{ pkgs, ...}:

with pkgs; [

# (import ./scripts/launcher.nix { inherit pkgs; })
(import ./scripts/battery.nix { inherit pkgs; })
(import ./scripts/nowplay.nix { inherit pkgs; })
(import ./scripts/audio-sink.nix { inherit pkgs; })


# Terminal Emulators
  kitty
  ghostty
  alacritty
  foot

# Shell Tools
  carapace
  zoxide
  cmatrix
  cbonsai
  cava
  scrcpy
  quickshell
  libnotify

# Development
  zig
  go
  nodejs
  zed-editor
  vim
  neovim
  git

# Browsers and Communication
  microsoft-edge
  discord
  kdePackages.kdeconnect-kde

# System Tools
  winbox4
  cloudflare-warp
  swaybg

# Media and Entertainment
  vlc
  pavucontrol
  sound-theme-freedesktop

# File Management and Viewers
  kdePackages.gwenview
  libreoffice
  gimp3
  swappy

# Wayland tools
  hyprlock
  hypridle
  wlogout
  waybar
  wlr-randr
  wlopm
  wl-clipboard

# Rofi and Related
  rofi
  rofimoji
  rofi-emoji

# System Tray and Notifications
  swaynotificationcenter
  nwg-dock
  blueman
  networkmanager
  caffeine-ng
  swayosd

# GTK Themes and Tools
  adw-gtk3
  gnome-tweaks
  gnome-extension-manager

# Qt5 and Qt6 theme tools
  libsForQt5.qtstyleplugins
  libsForQt5.qtquickcontrols2
  libsForQt5.qtgraphicaleffects

# Qt Wayland Support
  qt5.qtwayland
  qt6.qtwayland

# KDE/Breeze Themes
  kdePackages.breeze
  kdePackages.breeze-icons
  kdePackages.breeze-gtk

# Additional Qt Libraries
  libsForQt5.qtbase

# Theme utilities
  dconf-editor

# System Monitoring
  btop
  fastfetch
  neofetch

# Text Editor Alt
  onlyoffice-desktopeditors

# AI/ML Tools
  ollama
]
