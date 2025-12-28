# Installation Guide

## Prerequisites

- NixOS installed with Flakes enabled
- Git installed
- `sudo` access for system commands

### Enable Flakes (if not already enabled)

Add to `/etc/nixos/configuration.nix`:

```nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

Then rebuild:
```bash
sudo nixos-rebuild switch
```

## Installation Steps

### 1. Backup Current Configuration

```bash
sudo cp -r /etc/nixos /etc/nixos.backup
```

### 2. Clone NIXKs Repository

```bash
cd /tmp
git clone https://github.com/YasirFadhil/NIXKs.git
sudo cp -r NIXKs/* /etc/nixos/
cd /etc/nixos
```

### 3. Generate Hardware Configuration

```bash
sudo nixos-generate-hardware-configuration > /tmp/hw.nix
sudo cp /tmp/hw.nix /etc/nixos/host/chromebook/hardware-configuration.nix
```

### 4. Customize Configuration

Edit the following files for your system:

**`nixos/user.nix`** - Change username and user settings:
```nix
users.users.yourusername = {
  isNormalUser = true;
  home = "/home/yourusername";
  description = "Your Name";
  extraGroups = [ "networkmanager" "wheel" ];
  shell = pkgs.nushell;
};
```

**`nixos/networking.nix`** - Set hostname:
```nix
networking.hostname = "your-hostname";
```

**`nixos/localization.nix`** - Set timezone and locale:
```nix
time.timeZone = "America/New_York";
i18n.defaultLocale = "en_US.UTF-8";
```

**`home/home.nix`** - Update username and email:
```nix
home.username = "yourusername";
home.homeDirectory = "/home/yourusername";

programs.git = {
  enable = true;
  settings = {
    user.name = "Your Name";
    user.email = "your.email@example.com";
  };
};
```

### 5. Build and Switch

```bash
sudo nixos-rebuild switch --flake .#nixos
```

This may take a while on first build.

### 6. Setup Home Manager

```bash
home-manager switch --flake .#yourusername@nixos
```

### 7. Reboot

```bash
sudo reboot
```

## First Login

1. Log in with your username
2. Select **Niri** from the display manager session menu
3. Press `Super + Shift + /` to see keybindings overlay

## Troubleshooting

### Build fails with "not found"

Search for the package:
```bash
nix search nixpkgs packagename
```

### Home Manager won't apply

Verify username matches in all config files:
```bash
grep -r "yourusername" /etc/nixos/home/
```

### Niri won't start

Check if display manager is running:
```bash
systemctl status display-manager
```

View logs:
```bash
journalctl -xe
```

### Can't find package after rebuild

Rebuild home-manager:
```bash
home-manager switch --flake .
```

Log out and back in, then try again.

## Next Steps

- See [KEYBINDINGS.md](KEYBINDINGS.md) for Niri keybindings
- Customize packages in `home/packages.nix` and `nixos/environment.nix`
- Modify programs in `home/programs/` for your preferences
- Check `home/systems/niri/default.nix` for Niri configuration

## Useful Commands

```bash
# Rebuild system
sudo nixos-rebuild switch --flake .#nixos

# Rebuild home
home-manager switch --flake .#yourusername@nixos

# Test build
sudo nixos-rebuild dry-build --flake .

# Update packages
nix flake update

# Search packages
nix search nixpkgs <name>

# Check for errors
nix flake check

# Cleanup old generations
nix-collect-garbage -d
```

## Getting Help

- Check [KEYBINDINGS.md](KEYBINDINGS.md) for Niri shortcuts
- View logs: `journalctl -xe`
- Search NixOS packages: https://search.nixos.org/