# NIXKs

<img src="https://wiki.nixos.org/w/images/a/a1/Nix-snowflake-colours.svg" alt="NixOS Logo" width="80" />

Personal [NixOS](https://nixos.org/) + [Home Manager](https://github.com/nix-community/home-manager) setup with [Hyprland](https://hyprland.org/) and [Niri](https://github.com/sodiboo/niri) support.

## Features

- 🎯 **Declarative Configuration** - Everything defined in Nix for reproducibility
- 🪟 **Wayland-First** - Support for Hyprland and Niri compositors
- 📦 **Flakes-Based** - Modern NixOS with locked dependencies
- 🏠 **Home Manager** - User-level configuration management
- 🎨 **Pre-configured Programs** - Zed, Zen Browser, Spicetify, Nushell, and more
- 🔧 **Modular Structure** - Easy to customize and extend

## Directory Structure

```
.
├── flake.nix                          # Flake configuration
├── flake.lock                         # Locked dependencies
├── host/chromebook/                   # Host-specific config
├── nixos/                             # System-level configuration
├── home/                              # Home Manager configuration
│   ├── programs/                      # Program configurations
│   ├── systems/                       # Desktop environment setup
│   └── themes/                        # Theme and appearance
└── docs/                              # Additional documentation
```

## Quick Start

### Prerequisites
- NixOS installed with Flakes enabled
- Git installed

### Installation

```bash
# Clone the repository
git clone https://github.com/YasirFadhil/NIXKs.git /etc/nixos
cd /etc/nixos

# Build and switch
sudo nixos-rebuild switch --flake .#nixos

# Setup home-manager
home-manager switch --flake .#yasirfadhil@nixos
```

## Documentation

- **[GETTING_STARTED.md](GETTING_STARTED.md)** - Installation and setup guide
- **[QUICK_REFERENCE.md](QUICK_REFERENCE.md)** - Command cheatsheet and patterns
- **[CONTRIBUTING.md](CONTRIBUTING.md)** - How to contribute
- **[DOCUMENTATION.md](DOCUMENTATION.md)** - Documentation index

## Essential Commands

```bash
# Rebuild system
sudo nixos-rebuild switch --flake .#nixos

# Rebuild home-manager
home-manager switch --flake .#yasirfadhil@nixos

# Update flake inputs
nix flake update

# Check for errors
nix flake check

# Search for packages
nix search nixpkgs <package-name>

# Cleanup old generations
nix-collect-garbage -d
```

## Key Packages

**Desktop Environment:**
- Hyprland / Niri (window managers)
- Waybar (status bar)
- Rofi (app launcher)
- SwayNC (notifications)

**Programs:**
- Zed (code editor)
- Zen Browser (web browser)
- Ghostty (terminal)
- Nushell (shell)
- Spicetify (Spotify theming)

**System Tools:**
- btop (system monitor)
- fastfetch (system info)
- git (version control)

## Customization

### Change Default Shell
Edit `nixos/user.nix`:
```nix
users.users.yasirfadhil.shell = pkgs.nushell;
```

### Add System Package
Edit `nixos/environment.nix`:
```nix
environment.systemPackages = with pkgs; [
  newpackage
];
```

### Add User Package
Edit `home/packages.nix`:
```nix
with pkgs; [
  newpackage
]
```

### Add Program Configuration
Create `home/programs/myprogram/default.nix` and import in `home/home.nix`

## Flake Inputs

- **nixpkgs** - NixOS unstable packages
- **home-manager** - User configuration
- **niri** - Niri compositor
- **spicetify-nix** - Spotify customization
- **zen-browser** - Privacy-focused browser
- **apple-fonts** - Apple system fonts

## Troubleshooting

### Package not found
```bash
nix search nixpkgs <package-name>
```

### Configuration won't build
```bash
nix flake check
sudo nixos-rebuild build --show-trace
```

### Home Manager won't apply
```bash
# Verify username matches
grep "home.username" home/home.nix

# Build test
home-manager build --flake .
```

## Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [NixOS Wiki](https://nixos.wiki/)
- [Hyprland Wiki](https://wiki.hyprland.org/)

## Credits & Inspiration

This configuration is inspired by:
- Community NixOS configurations
- [NixOS wiki](https://nixos.wiki/)

---

> Made with ❤️ by [YasirFadhil](https://github.com/YasirFadhil)