# NIXKs - NixOS Configuration

A declarative, reproducible NixOS configuration using Flakes with Home Manager integration. This setup provides a complete development and desktop environment optimized for productivity and customization.

## 🎯 Overview

**NIXKs** is a modern NixOS configuration built with:
- **Flakes** for reproducible builds and dependency management
- **Home Manager** for user-level configuration
- **Modular structure** for easy maintenance and customization
- **Wayland-first** desktop environment (Hyprland + Niri support)
- **Multiple programs** pre-configured (Zed, Zen Browser, Spicetify, and more)

### Key Features

✨ **Modular Design** - Organized into system, home, and host-specific configurations
🎨 **Multiple Desktop Environments** - Support for Hyprland and Niri
🎵 **Pre-configured Programs** - Zed editor, Zen Browser, Spicetify, Nushell, and more
📦 **Declarative Package Management** - All packages defined in Nix
🔧 **Customizable Themes** - GTK themes, icons, and cursor themes included
🚀 **Development Ready** - Multiple programming language toolchains available

## 📁 Directory Structure

```
.
├── flake.nix                          # Flake configuration and inputs
├── flake.lock                         # Locked dependency versions
├── LICENSE                            # Project license
├── README.md                          # This file
│
├── host/                              # Host-specific configurations
│   └── chromebook/
│       ├── configuration.nix          # Main host configuration
│       └── hardware-configuration.nix # Hardware-specific settings
│
├── nixos/                             # System-level configurations
│   ├── audio.nix                      # Audio system setup (PulseAudio/PipeWire)
│   ├── bootloader.nix                 # GRUB/EFI bootloader configuration
│   ├── environment.nix                # System-wide packages
│   ├── localization.nix               # Locale, timezone, and keyboard layout
│   ├── networking.nix                 # Network, DNS, and hostname settings
│   ├── power-button.nix               # Power management and button handling
│   ├── session-manager.nix            # Display server and session configuration
│   ├── user.nix                       # User account creation and settings
│   ├── var-conf.nix                   # Variable definitions and shared config
│   └── virtual.nix                    # Virtual machine/container settings
│
├── home/                              # Home Manager user configuration
│   ├── home.nix                       # Main home configuration
│   ├── packages.nix                   # User-level packages
│   ├── var.nix                        # Home-level variables
│   ├── nh.nix                         # Nix helper configuration
│   │
│   ├── systems/                       # Desktop environment configurations
│   │   ├── hypr/                      # Hyprland window manager setup
│   │   ├── niri/                      # Niri compositor setup
│   │   ├── swaync/                    # SwayNC notification daemon
│   │   └── waybar/                    # Waybar status bar
│   │
│   ├── programs/                      # Application configurations
│   │   ├── fastfetch/                 # System information display
│   │   ├── ghostty/                   # Ghostty terminal
│   │   ├── nushell/                   # Nushell shell configuration
│   │   ├── rofi/                      # Rofi app launcher
│   │   ├── spicetify/                 # Spotify customization
│   │   ├── starship/                  # Starship prompt
│   │   ├── zed/                       # Zed editor configuration
│   │   └── zen/                       # Zen Browser configuration
│   │
│   ├── themes/                        # Theme and appearance settings
│   └── scripts/                       # User scripts and utilities
│
└── docs/                              # Documentation
    ├── PACKAGE_ORGANIZATION.md        # Guide to system vs home packages
    ├── ROFI_BENEFITS.md               # Rofi launcher benefits
    └── ROFI_SETUP.md                  # Rofi setup guide
```

## 🚀 Quick Start

### Prerequisites

- NixOS installed with Flakes support
- Git installed
- A compatible Linux kernel (x86_64-linux)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/YasirFadhil/NIXKs.git /etc/nixos
   cd /etc/nixos
   ```

2. **Update flake inputs (optional):**
   ```bash
   nix flake update
   ```

3. **Apply the configuration:**
   ```bash
   sudo nixos-rebuild switch --flake .#nixos
   ```

4. **Build Home Manager configuration:**
   ```bash
   home-manager switch --flake .#yasirfadhil@nixos
   ```

## 🔌 Flake Inputs

This configuration uses the following external flake inputs:

| Input | Purpose | Link |
|-------|---------|------|
| **nixpkgs** | Unstable NixOS packages | [nixos/nixpkgs](https://github.com/nixos/nixpkgs) |
| **home-manager** | User-level configuration | [nix-community/home-manager](https://github.com/nix-community/home-manager) |
| **niri** | Niri wayland compositor | [sodiboo/niri-flake](https://github.com/sodiboo/niri-flake) |
| **spicetify-nix** | Spotify customization | [Gerg-L/spicetify-nix](https://github.com/Gerg-L/spicetify-nix) |
| **zen-browser** | Privacy-focused browser | [youwen5/zen-browser-flake](https://github.com/youwen5/zen-browser-flake) |
| **apple-fonts** | Apple system fonts | [Lyndeno/apple-fonts.nix](https://github.com/Lyndeno/apple-fonts.nix) |

## 📦 Key Packages & Applications

### System Tools
- **btop** - Advanced system monitor
- **fastfetch** - System information display
- **brightnessctl** - Brightness control
- **pavucontrol** - PulseAudio volume control
- **networkmanagerapplet** - Network management

### Terminals & Shells
- **Ghostty** - Modern terminal emulator
- **Nushell** - Modern shell with structured data
- **Starship** - Cross-shell prompt

### Development
- **Zed Editor** - Modern code editor
- **Git** - Version control
- **Multiple Language Toolchains** - Zig, Go, Node.js, etc.

### Desktop Environments
- **Hyprland** - Dynamic tiling window manager
- **Niri** - Wayland compositor
- **Waybar** - Status bar
- **Rofi** - Application launcher
- **SwayNC** - Notification daemon

### Media & Creative
- **Zen Browser** - Privacy-focused web browser
- **Spicetify** - Spotify theme customization
- **VLC** - Media player
- **OBS Studio** - Screen recording/streaming

## ⚙️ Configuration Files Explained

### System Configuration (`nixos/`)

**`environment.nix`** - System-wide packages
- Core utilities (curl, wget, git)
- Audio system (PipeWire/PulseAudio)
- Display server components
- Theme and icon packages

**`bootloader.nix`** - Boot configuration
- GRUB/EFI setup
- Boot parameters and timeout

**`audio.nix`** - Audio system
- PulseAudio or PipeWire configuration
- Audio daemon settings

**`networking.nix`** - Network setup
- Hostname configuration
- DNS settings
- NetworkManager or systemd-networkd

**`user.nix`** - User accounts
- User creation and groups
- Shell and home directory setup

**`localization.nix`** - Region and language
- Locale settings
- Timezone configuration
- Keyboard layout

### Home Manager Configuration (`home/`)

**`home.nix`** - Main entry point
- Home directory setup
- User information
- Module imports

**`packages.nix`** - User packages
- User applications
- Development tools
- Terminal utilities

**`programs/`** - Per-program configuration
- Each subdirectory contains configuration for specific applications
- Includes settings, keybindings, themes, etc.

**`systems/`** - Desktop environment setup
- Window manager configuration (Hyprland/Niri)
- Status bar and notification setup
- Display protocol configuration

**`themes/`** - Appearance customization
- GTK themes and settings
- Icon themes
- Cursor themes
- QT configuration

## 🎨 Customization Guide

### Changing the Desktop Environment

1. **To use Hyprland** (default):
   - Edit `home/home.nix` and ensure `./systems/hypr` is imported
   - Customize `home/systems/hypr/default.nix`

2. **To switch to Niri**:
   - Import `./systems/niri` in `home/home.nix`
   - Disable Hyprland if needed
   - Configure in `home/systems/niri/default.nix`

### Adding New Programs

1. Create a directory in `home/programs/`
2. Add program configuration in `default.nix`
3. Import it in `home/home.nix`

Example:
```nix
# home/programs/myapp/default.nix
{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ myapp ];
  # Configure settings here
}
```

Then in `home/home.nix`:
```nix
imports = [
  ./programs/myapp
  # ... other imports
];
```

### Adding System Packages

Edit `nixos/environment.nix`:
```nix
environment.systemPackages = with pkgs; [
  # Add your package here
  mypackage
];
```

### Modifying Themes

Edit `home/themes/default.nix` to change:
- GTK theme
- Icon theme
- Cursor theme
- QT configuration

## 🔄 Rebuilding

### System Configuration
```bash
sudo nixos-rebuild switch --flake .#nixos
```

### Home Manager Configuration
```bash
home-manager switch --flake .#yasirfadhil@nixos
```

### Both (recommended)
```bash
sudo nixos-rebuild switch --flake .#nixos && home-manager switch --flake .#yasirfadhil@nixos
```

### Testing Changes (dry-run)
```bash
sudo nixos-rebuild dry-build --flake .#nixos
```

## 📚 Documentation

Additional documentation is available in the `docs/` directory:

- **PACKAGE_ORGANIZATION.md** - Guide to organizing system vs home packages
- **ROFI_SETUP.md** - Setting up and configuring Rofi launcher
- **ROFI_BENEFITS.md** - Benefits of using Rofi for application launching

## 🐛 Troubleshooting

### Configuration won't build
1. Check flake inputs are accessible: `nix flake update`
2. Verify syntax: `nix flake check`
3. Check for evaluation errors: `nix eval --impure .#`

### Home Manager not applying
1. Ensure user is correctly set in `home/home.nix`
2. Verify state version matches: `home.stateVersion`
3. Run with verbose output: `home-manager switch -v`

### Programs not starting
1. Check if package is installed: `which programname`
2. Verify in appropriate configuration (system vs home)
3. Check package name in nixpkgs: `nix search nixpkgs myprogram`

### Theme not applying
1. Log out and back in
2. Restart the desktop environment
3. Check `home/themes/` configuration

## 🤝 Contributing

Feel free to fork this repository and customize it for your needs. Some suggestions:

- Modify host-specific settings in `host/chromebook/`
- Add your own programs in `home/programs/`
- Create additional desktop environment configs in `home/systems/`
- Share improvements via pull requests

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👤 Author

**Yasir Fadhil**
- GitHub: [@YasirFadhil](https://github.com/YasirFadhil)
- Email: yasirfadhil46@gmail.com

## 🔗 Useful Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Nix Flakes Documentation](https://nixos.wiki/wiki/Flakes)
- [Hyprland Wiki](https://wiki.hyprland.org/)
- [NixOS Wiki](https://nixos.wiki/)

## 📋 Cheat Sheet

```bash
# Rebuild system
sudo nixos-rebuild switch --flake .#nixos

# Rebuild home
home-manager switch --flake .#yasirfadhil@nixos

# Update all flake inputs
nix flake update

# Update specific input
nix flake update nixpkgs

# Check flake validity
nix flake check

# List flake outputs
nix flake show

# Garbage collection (cleanup)
nix-collect-garbage -d

# Search for packages
nix search nixpkgs <package-name>

# Show system info
neofetch
fastfetch
```

---

Made with ❤️ using NixOS and Nix Flakes
