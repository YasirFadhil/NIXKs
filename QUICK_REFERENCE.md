# NIXKs Quick Reference Guide

Fast lookup for common commands and patterns.

## Essential Commands

### Rebuilding Configuration

```bash
# Rebuild system configuration
sudo nixos-rebuild switch --flake .#nixos

# Rebuild home-manager configuration
home-manager switch --flake .#yasirfadhil@nixos

# Test build without applying changes
sudo nixos-rebuild dry-build --flake .#nixos

# Build without switching (creates result symlink)
sudo nixos-rebuild build --flake .#nixos
```

### Flake Operations

```bash
# Update all flake inputs to latest versions
nix flake update

# Update specific input
nix flake update nixpkgs

# Check flake for errors
nix flake check

# Show flake structure and outputs
nix flake show

# Evaluate flake configuration
nix eval --impure .#nixosConfigurations
```

### Package Management

```bash
# Search for a package in nixpkgs
nix search nixpkgs <package-name>

# Show installed packages
nix profile show

# Open temporary shell with package
nix shell nixpkgs#<package-name>

# Create temporary environment
nix-shell -p package1 package2
```

### System Information

```bash
# Show NixOS version
nixos-version

# Detailed version info
nixos-version --detailed

# View system logs
journalctl -xe

# View service logs
journalctl -u service-name

# Check hardware info
sudo lspci
sudo lsusb

# View current hardware config
cat /etc/nixos/host/chromebook/hardware-configuration.nix
```

### Cleanup and Maintenance

```bash
# Remove old generations and unused packages
nix-collect-garbage -d

# Delete home-manager generations older than 30 days
home-manager expire-generations 30d

# Optimize nix store
nix store optimise

# Check nix store size
du -sh /nix/store
```

## Configuration Patterns

### Add System-Wide Package

Edit `nixos/environment.nix`:

```nix
environment.systemPackages = with pkgs; [
  # existing packages...
  newpackage
];
```

Then rebuild: `sudo nixos-rebuild switch --flake .#nixos`

### Add User Package

Edit `home/packages.nix`:

```nix
with pkgs; [
  # existing packages...
  newpackage
]
```

Then rebuild: `home-manager switch --flake .#yasirfadhil@nixos`

### Add Program Configuration

1. Create directory:
   ```bash
   mkdir -p home/programs/myprogram
   ```

2. Create `home/programs/myprogram/default.nix`:
   ```nix
   { config, pkgs, ... }:
   {
     home.packages = with pkgs; [ myprogram ];
     programs.myprogram.enable = true;
     programs.myprogram.settings = {
       option1 = "value";
     };
   }
   ```

3. Add import to `home/home.nix`:
   ```nix
   imports = [
     ./programs/myprogram
   ];
   ```

4. Rebuild home-manager

### Set Environment Variables

In `home/home.nix`:

```nix
home.sessionVariables = {
  EDITOR = "nvim";
  BROWSER = "firefox";
  PATH = "/path/to/add:$PATH";
};
```

### Create Shell Aliases

In program config or `home/home.nix`:

```nix
home.shellAliases = {
  ll = "ls -lah";
  update = "home-manager switch --flake .";
  rebuild = "sudo nixos-rebuild switch --flake .#nixos";
};
```

## Common Customizations

### Change Default Shell

Edit `nixos/user.nix`:

```nix
users.users.yasirfadhil.shell = pkgs.nushell;
# or
users.users.yasirfadhil.shell = pkgs.zsh;
# or
users.users.yasirfadhil.shell = pkgs.fish;
```

### Set System Hostname

Edit `nixos/networking.nix`:

```nix
networking.hostname = "my-computer";
```

### Set Timezone

Edit `nixos/localization.nix`:

```nix
time.timeZone = "America/New_York";
# or
time.timeZone = "Europe/London";
# or
time.timeZone = "Asia/Tokyo";
```

### Set Keyboard Layout

Edit `nixos/localization.nix`:

```nix
services.xserver.xkb.layout = "us";
services.xserver.xkb.variant = "dvp";
services.xserver.xkb.options = "caps:escape";
```

### Enable System Service

Edit appropriate nixos config file:

```nix
services.myservice.enable = true;
```

### Disable System Service

```nix
services.myservice.enable = false;
```

## Key File Locations

| Path | Purpose |
|------|---------|
| `/etc/nixos/flake.nix` | Main flake configuration and inputs |
| `/etc/nixos/flake.lock` | Locked dependency versions |
| `/etc/nixos/host/chromebook/` | Host-specific configs |
| `/etc/nixos/nixos/` | System-level modules |
| `/etc/nixos/home/` | Home Manager configuration |
| `/etc/nixos/home/programs/` | Individual program configs |
| `/etc/nixos/home/systems/` | Desktop environment configs |
| `/etc/nixos/home/packages.nix` | User packages |
| `/etc/nixos/nixos/environment.nix` | System packages |
| `/etc/nixos/docs/` | Additional documentation |

## Troubleshooting Quick Tips

### Package Not Found Error

```bash
# Search for correct package name
nix search nixpkgs mypackage

# Or search online
# https://search.nixos.org/packages
```

### Configuration Won't Build

```bash
# Check syntax errors
nix flake check

# Detailed error output
sudo nixos-rebuild build --show-trace

# Evaluate configuration
nix eval --impure .#nixosConfigurations 2>&1 | less
```

### Home Manager Won't Apply

```bash
# Verify username matches in home.nix
grep "home.username" home/home.nix

# Build to check for errors
home-manager build --flake .

# Check state version
grep "stateVersion" home/home.nix
```

### Program Not Found After Install

```bash
# Verify package is installed
which myprogram

# Check which config contains it
grep -r "myprogram" nixos/ home/

# Rebuild home manager
home-manager switch --flake .

# Log out and back in
# Then try again
```

### Desktop Environment Won't Start

```bash
# Check display manager status
systemctl status display-manager

# View logs
journalctl -xe

# Verify WM is installed
which hyprland
which niri

# Check available sessions
ls /run/current-system/share/wayland-sessions/
```

## Git Workflow

### Initialize Git Repository

```bash
cd /etc/nixos
git init
git add .
git commit -m "Initial NixOS configuration"
```

### Create Feature Branch

```bash
git checkout -b feature/my-feature
```

### Commit Changes

```bash
git add .
git commit -m "feat: Add my feature"
```

### Push to Remote

```bash
git push origin feature/my-feature
```

### Rollback to Previous Commit

```bash
git reset --hard HEAD~1
sudo nixos-rebuild switch --flake .
```

## Useful Resources

### Official Documentation

- **NixOS Manual**: https://nixos.org/manual/nixos/stable/
- **Home Manager Manual**: https://nix-community.github.io/home-manager/
- **Package Search**: https://search.nixos.org/packages
- **Options Search**: https://search.nixos.org/options
- **NixOS Wiki**: https://nixos.wiki/

### Community

- **NixOS Discourse**: https://discourse.nixos.org/
- **Reddit**: https://www.reddit.com/r/NixOS/
- **GitHub Issues**: Open issue in NIXKs repository

### Learning

- **Nix Pills**: https://nixos.org/guides/nix-pills/
- **Nix Manual**: https://nixos.org/manual/nix/stable/
- **Home Manager Docs**: https://nix-community.github.io/home-manager/options.html

## Best Practices

1. **Always backup before major changes**:
   ```bash
   sudo cp -r /etc/nixos /etc/nixos.backup.$(date +%s)
   ```

2. **Use dry-run before applying**:
   ```bash
   sudo nixos-rebuild dry-build --flake .
   ```

3. **Keep generations for rollback**:
   ```bash
   nix-collect-garbage --delete-old
   ```

4. **Test changes locally first**:
   ```bash
   sudo nixos-rebuild build --flake .
   ```

5. **Use git to track changes**:
   ```bash
   cd /etc/nixos && git add -A && git commit
   ```

6. **Document custom modifications**:
   - Add comments explaining why changes were made
   - Keep notes of any custom settings

7. **Update regularly but carefully**:
   ```bash
   nix flake update
   sudo nixos-rebuild dry-build --flake .
   ```

## Performance Tips

1. Use `nix flake lock` instead of `update` to avoid unnecessary updates
2. Keep system packages minimal - move to home packages when possible
3. Remove old generations regularly with `nix-collect-garbage -d`
4. Consider using local Nix cache during development
5. Use `--show-trace` for debugging build issues

## Common Issues & Solutions

| Issue | Solution |
|-------|----------|
| "attribute 'X' missing" | Check flake inputs are accessible: `nix flake update` |
| "Package not found" | Search with `nix search nixpkgs` or https://search.nixos.org |
| Home Manager won't apply | Verify username and state version match |
| Desktop won't start | Check display manager is enabled and WM is installed |
| Slow rebuilds | Reduce system packages, clean with `nix-collect-garbage` |
| Out of disk space | Run `nix-collect-garbage -d` to reclaim space |

## Quick Command Cheatsheet

```bash
# Rebuild everything
sudo nixos-rebuild switch --flake .#nixos && home-manager switch

# Update and rebuild
nix flake update && sudo nixos-rebuild switch --flake .

# Just home-manager
home-manager switch --flake .

# Test without applying
sudo nixos-rebuild dry-build --flake .

# Check for errors
nix flake check

# Search packages
nix search nixpkgs <name>

# Clean up
nix-collect-garbage -d

# View logs
journalctl -xe

# System info
neofetch
fastfetch
nixos-version --detailed
```

---

For detailed information, see:
- [README.md](README.md) - Overview and structure
- [GETTING_STARTED.md](GETTING_STARTED.md) - Installation guide
- [CONTRIBUTING.md](CONTRIBUTING.md) - How to contribute
- [docs/](docs/) - Additional documentation