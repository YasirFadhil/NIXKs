# NixOS Package Organization Guide

## Overview
This document explains the organization strategy for packages across your NixOS system configuration.

## System Packages (`/etc/nixos/nixos/environment.nix`)

**Purpose:** System-wide packages available to all users and services.

### Packages to Include:
- **Core System Utilities**: wget, curl, git, udisks, dbus, gvfs
- **Audio/Video System**: alsa-utils, alsa-ucm-conf, pamixer, playerctl, ffmpeg_7
- **System Monitoring**: btop, fastfetch, neofetch (useful for all users)
- **Essential Editors**: vim, neovim (available system-wide)
- **Shells**: fish, zsh, nushell, starship (can be used by any user)
- **Display Servers & Protocols**: Wayland, Xorg, xdg-desktop-portal
- **System Libraries**: GTK, Qt, GNOME libraries
- **Theme/Icons (System-wide)**: whitesur-gtk-theme, bibata-cursors (everyone benefits)
- **Qt Configuration**: libsForQt5.qt5ct, qt6Packages.qt6ct
- **Boot/EFI Tools**: efibootmgr, polkit_gnome
- **Network System**: samba, cifs-utils, networkmanagerapplet
- **System Control**: brightnessctl, upower

## Home Packages (`/etc/nixos/home/packages.nix`)

**Purpose:** User-specific applications and tools.

### Packages to Include:
- **Terminal Emulators**: kitty, ghostty, alacritty, foot
- **User Applications**: Discord, Browsers, VLC, GIMP, Blender, OBS
- **Development Tools (User)**: zig, go, nodejs, zed-editor
- **Text Editors (User)**: vim, neovim, zed-editor (user preference versions)
- **Shell Tools**: carapace, zoxide, cmatrix, cbonsai, cava
- **Desktop Environment**: rofi, waybar, hyprlock, hypridle, wlogout
- **Notification System**: swaynotificationcenter, nwg-dock
- **User Monitoring**: btop, fastfetch (user convenience)
- **Theme Customization**: adw-gtk3, gnome-tweaks, gnome-extension-manager
- **File Management**: gwenview, libreoffice, gimp3, swappy
- **Media Tools**: obs-studio, pavucontrol, vlc
- **Wayland Tools**: hyprlock, hypridle, wl-clipboard
- **AI/ML Tools**: ollama (user application)
- **Network Tools**: cloudflare-warp, winbox4, blueman

## Duplicates Removed

### Removed from Home (kept in System):
- ✓ whitesur-gtk-theme
- ✓ whitesur-icon-theme
- ✓ bibata-cursors
- ✓ libsForQt5.qt5ct
- ✓ qt6Packages.qt6ct
- ✓ libsForQt5.qtstyleplugin-kvantum
- ✓ networkmanagerapplet

### Added to Home (removed from System):
- ✓ zed-editor
- ✓ vim
- ✓ neovim
- ✓ git
- ✓ btop
- ✓ fastfetch
- ✓ neofetch
- ✓ ollama

## Best Practices

1. **System packages** should be minimal and focus on:
   - Core system functionality
   - Libraries needed by multiple applications
   - Display servers and protocols
   - System monitoring tools

2. **Home packages** should include:
   - User-facing applications
   - Development tools for personal use
   - Terminal applications
   - Desktop environment customization

3. **Avoid duplication**: Check both files before adding packages

4. **Size Considerations**:
   - System closure will be built for all users
   - Keep it lean to reduce rebuild time
   - Prefer home packages for large applications (GIMP, OBS, etc.)

## File Locations

- System: `/etc/nixos/nixos/environment.nix`
- Home: `/etc/nixos/home/packages.nix`
- Configuration: Review and maintain according to this guide