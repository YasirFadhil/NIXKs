# Getting Started with NIXKs

Welcome to NIXKs! This guide will help you get up and running with this NixOS configuration quickly.

## Prerequisites

Before you begin, make sure you have:

1. **NixOS Installed** - A working NixOS system
2. **Flakes Enabled** - Nix with flakes support (usually enabled by default on recent NixOS)
3. **Git Installed** - For cloning the repository
4. **Root Access** - You'll need `sudo` for system configuration changes

### Check if Flakes are Enabled

```bash
nix flake --version
```

If you get an error about "unknown command", enable flakes in `/etc/nix/nix.conf`:

```
experimental-features = nix-command flakes
```

Then restart the Nix daemon:
```bash
sudo systemctl restart nix-daemon
```

## Installation Steps

### Step 1: Backup Existing Configuration

Before proceeding, backup your current NixOS configuration:

```bash
sudo cp -r /etc/nixos /etc/nixos.backup
```

### Step 2: Clone the Repository

Clone NIXKs to your NixOS directory:

```bash
sudo git clone https://github.com/YasirFadhil/NIXKs.git /etc/nixos
cd /etc/nixos
```

### Step 3: Customize for Your System

Edit the configuration to match your hardware:

1. **Check your hardware configuration:**
   ```bash
   sudo nixos-generate-hardware-configuration > /tmp/hw.nix
   cat /tmp/hw.nix
   ```

2. **Update `host/chromebook/hardware-configuration.nix`** with your hardware details

3. **Edit `host/chromebook/configuration.nix`** if needed:
   - Change hostname in `networking.nix`
   - Adjust bootloader settings in `nixos/bootloader.nix`
   - Update user in `nixos/user.nix`

### Step 4: Build and Switch

Apply the configuration:

```bash
# Update flake inputs (get latest packages)
sudo nix flake update

# Build and apply the system configuration
sudo nixos-rebuild switch --flake .#nixos
```

This may take a while depending on your internet connection and system resources.

### Step 5: Setup Home Manager

After the system rebuild completes, set up Home Manager for your user:

```bash
# First, install home-manager
nix run github:nix-community/home-manager -- --version

# Apply home-manager configuration
home-manager switch --flake .#yasirfadhil@nixos
```

Replace `yasirfadhil` with your username if different.

### Step 6: Restart and Verify

Restart your system to ensure everything is properly initialized:

```bash
sudo reboot
```

After restarting, verify the installation:

```bash
# Check NixOS version
nixos-version

# Check Home Manager
home-manager switch --flake .#yasirfadhil@nixos
```

## First-Time Configuration

### Customizing Your User

Edit `nixos/user.nix` to customize user settings:

```nix
users.users.yasirfadhil = {
  isNormalUser = true;
  home = "/home/yasirfadhil";
  description = "Your Name";
  extraGroups = [ "networkmanager" "wheel" ];
  shell = pkgs.nushell;  # Change default shell
};
```

### Choosing Your Desktop Environment

Edit `home/home.nix` and adjust the imports:

**For Hyprland (default):**
```nix
imports = [
  ./systems/hypr
  # ... other imports
];
```

**For Niri:**
```nix
imports = [
  ./systems/niri
  # ... other imports
];
```

### Setting Display Manager

Edit `nixos/session-manager.nix` to choose your display manager:

```nix
services.xserver.displayManager.gdm.enable = true;  # GNOME Display Manager
# or
services.xserver.displayManager.sddm.enable = true; # SDDM
```

## Daily Workflow

### Rebuilding After Changes

After modifying any Nix files:

```bash
# For system-level changes
sudo nixos-rebuild switch --flake .#nixos

# For user-level changes
home-manager switch --flake .#yasirfadhil@nixos

# For both
sudo nixos-rebuild switch --flake .#nixos && home-manager switch --flake .#yasirfadhil@nixos
```

### Using nh (Nix Helper)

For a simpler workflow, use `nh`:

```bash
# Add to your packages
home.packages = with pkgs; [ nh ];

# Then use:
nh os switch     # Rebuild system
nh home switch   # Rebuild home-manager
nh news          # Check for news
```

### Testing Changes

Before applying changes, do a dry run:

```bash
# Test system configuration
sudo nixos-rebuild dry-build --flake .#nixos

# Test home configuration
home-manager build --flake .#yasirfadhil@nixos
```

## Adding New Packages

### Adding System-Wide Packages

Edit `nixos/environment.nix`:

```nix
environment.systemPackages = with pkgs; [
  # Existing packages...
  mynewpackage  # Add here
];
```

Then rebuild:
```bash
sudo nixos-rebuild switch --flake .#nixos
```

### Adding User Packages

Edit `home/packages.nix`:

```nix
with pkgs; [
  # Existing packages...
  mynewpackage  # Add here
]
```

Then rebuild:
```bash
home-manager switch --flake .#yasirfadhil@nixos
```

## Configuring Programs

Each program has its own configuration directory. Examples:

### Terminal (Ghostty)

Edit `home/programs/ghostty/default.nix` to customize:
- Font and size
- Colors and theme
- Keybindings
- Shell configuration

### Shell (Nushell)

Configure in `home/programs/nushell/default.nix`:
- Aliases
- Functions
- Environment variables
- Module loading

### Editor (Zed)

Edit `home/programs/zed/default.nix`:
- Theme selection
- Font settings
- Extensions
- Keybindings

### Window Manager (Hyprland)

Customize `home/systems/hypr/default.nix`:
- Keybindings
- Monitor configuration
- Workspace settings
- General appearance

## Troubleshooting

### Build Fails with "not found"

The package might not exist in nixpkgs:

```bash
# Search for the package
nix search nixpkgs packagename

# Or check online
# https://search.nixos.org/packages
```

### Home Manager Won't Switch

Common issues:

1. **State version mismatch** - Update `home.stateVersion` in `home/home.nix`
2. **User doesn't exist** - Run system rebuild first: `sudo nixos-rebuild switch --flake .#nixos`
3. **Permission issues** - Ensure you're running from the correct directory

### Desktop Environment Won't Start

1. Check if display manager is enabled:
   ```bash
   systemctl status display-manager
   ```

2. View logs:
   ```bash
   journalctl -xe
   ```

3. Verify desktop environment is imported in `home/home.nix`

### Programs Not in PATH

After adding a package:

1. Rebuild the configuration
2. Log out and back in
3. Open a new terminal
4. Verify: `which programname`

## Next Steps

1. **Read the main README** - Get a better overview of the project structure
2. **Explore the documentation** in `docs/` directory
3. **Customize theme** - Edit `home/themes/` to match your preferences
4. **Configure programs** - Personalize each program in `home/programs/`
5. **Add your scripts** - Create personal scripts in `home/scripts/`

## Getting Help

### Resources

- **NixOS Manual**: https://nixos.org/manual/nixos/stable/
- **Home Manager Manual**: https://nix-community.github.io/home-manager/
- **NixOS Wiki**: https://nixos.wiki/
- **Nix Pills**: https://nixos.org/guides/nix-pills/

### Check for Issues

- Look in `docs/` for specific setup guides
- Check `README.md` for overview and structure
- Review existing configurations for examples

### Ask for Help

- GitHub Issues: Open an issue in the repository
- NixOS Discourse: https://discourse.nixos.org/
- Reddit: https://www.reddit.com/r/NixOS/

## Quick Reference

### Essential Commands

```bash
# Rebuild system
sudo nixos-rebuild switch --flake .#nixos

# Rebuild home
home-manager switch --flake .#yasirfadhil@nixos

# Update packages
nix flake update

# Check configuration
nix flake check

# Search for packages
nix search nixpkgs <name>

# Clean up old generations
nix-collect-garbage -d

# View flake inputs/outputs
nix flake show

# Show current configuration
sudo nixos-option system.activationScripts
```

### File Locations

- **System config**: `/etc/nixos/host/chromebook/configuration.nix`
- **Home config**: `/etc/nixos/home/home.nix`
- **System packages**: `/etc/nixos/nixos/environment.nix`
- **User packages**: `/etc/nixos/home/packages.nix`
- **Flake config**: `/etc/nixos/flake.nix`

## Tips & Tricks

1. **Keep a backup** - Always keep a backup of `/etc/nixos`
2. **Test before rebuilding** - Use `dry-build` to test changes
3. **Read error messages** - NixOS errors are usually informative
4. **Use `git`** - Track changes to your configuration with git
5. **Join the community** - Ask questions on NixOS Discourse

---

Happy hacking! 🚀