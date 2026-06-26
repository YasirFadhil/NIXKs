{ pkgs, inputs ? {}, ... }:

#let
 # extraGames = if inputs ? freesmlauncher then [ inputs.freesmlauncher.packages."${pkgs.stdenv.hostPlatform.system}".default ] else [];
#in

with pkgs; ([
(import ./scripts/battery.nix { inherit pkgs; })
(import ./scripts/nowplay.nix { inherit pkgs; })
# (import ./scripts/audio-sink.nix { inherit pkgs; })


# Terminal Emulators
  kitty
  ghostty
  alacritty
  foot
  # claude-code

# Shell Tools
  carapace
  zoxide
  cmatrix
  cbonsai
  cava
  scrcpy
  libnotify
  psmisc
 # cisco-packet-tracer_9

# Development
  zig
  go
  nodejs
  zed-editor
  vim
  neovim
  antigravity
  git
  pywal

# Browsers and Communication
 # microsoft-edge
  discord
  element-desktop
  google-chrome
  kdePackages.kdeconnect-kde
  kdePackages.krdp
  kdePackages.krdc

# System Tools
  winbox4
  swaybg
  hyphen
  mpvpaper
  nwg-look

# Media and Entertainment
  vlc
  pavucontrol
  sound-theme-freedesktop
  obs-studio
  # spotify

# File Management and Viewers
  kdePackages.gwenview
  libreoffice
  gimp3
  swappy
  yazi

# Wayland tools
  eww
  hyprlock
  hypridle
  hyprshot
  wlogout
  waybar
  wlr-randr
  wlopm
  wl-clipboard
  swaylock-effects

# Rofi and Related
 rofi
 # rofimoji
 # rofi-emoji

# System Tray and Notifications
  # swaynotificationcenter
  # nwg-dock
  blueman
  networkmanager
  caffeine-ng

# GTK Themes and Tools
  gnome-tweaks
  gnome-extension-manager

# Qt5 and Qt6 theme tools
  libsForQt5.qtstyleplugins
  libsForQt5.qtquickcontrols2
  libsForQt5.qtgraphicaleffects

# Qt Wayland Support
  qt5.qtwayland
  qt6.qtwayland
  qt6.qtwebsockets

# Additional Qt Libraries
  libsForQt5.qtbase

# Theme utilities
  dconf-editor

# System Monitoring
  btop
  fastfetch

# Text Editor Alt
  onlyoffice-desktopeditors

# Games
#] ++ extraGames ++ [
]
)
