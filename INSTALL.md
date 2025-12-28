# Installation Guide

## Prerequisites

- NixOS installed with Flakes enabled
- Git installed
- `sudo` access

## Step 1: Clone Repository

```bash
cd /tmp
git clone https://github.com/YasirFadhil/NIXKs.git
sudo cp -r NIXKs/* /etc/nixos/
cd /etc/nixos
```

## Step 2: Generate Hardware Configuration

```bash
sudo nixos-generate-hardware-configuration > /tmp/hw.nix
sudo cp /tmp/hw.nix host/chromebook/hardware-configuration.nix
```

## Step 3: Customize Configuration

### Update Username

Edit `nixos/user.nix`:
```nix
users.users.YOUR_USERNAME = {
  isNormalUser = true;
  home = "/home/YOUR_USERNAME";
  description = "Your Name";
  extraGroups = [ "networkmanager" "wheel" ];
  shell = pkgs.nushell;
};
```

Edit `home/home.nix`:
```nix
home.username = "YOUR_USERNAME";
home.homeDirectory = "/home/YOUR_USERNAME";

programs.git = {
  enable = true;
  settings = {
    user.name = "Your Name";
    user.email = "your.email@example.com";
  };
};
```

Edit `host/chromebook/configuration.nix`:
```nix
home-manager.users.YOUR_USERNAME = import ./home/home.nix;
```
## note you may change the name of chromebook to your devices name

### Set Hostname

Edit `nixos/networking.nix`:
```nix
networking.hostname = "nixos"; #the default nixos hostname
```

### Set Timezone

Edit `nixos/localization.nix`:
```nix
time.timeZone = "Your_Region/City";
```

## Step 4: First Build

```bash
sudo nixos-rebuild switch --flake .#nixos
```

This is the initial build. It may take a while.

## Step 5: Reboot

```bash
reboot
```

Log in and select **Session You Want** from the display manager.

## Future Rebuilds

After the first build, use `nh` as nixos helper:

```bash
nh os switch /etc/nixos -H nixos --ask
```

## Customize Niri

Edit `home/systems/niri/default.nix` for:
- Keybindings (see KEYBINDINGS.md)
- Display settings
- Window rules
- Startup programs

## Add Packages

### System Package

Edit `nixos/environment.nix`:
```nix
environment.systemPackages = with pkgs; [
  newpackage
];
```

Rebuild with:
```bash
nh os switch /etc/nixos -H nixos --ask
```

### User Package

Edit `home/packages.nix`:
```nix
with pkgs; [
  newpackage
]
```

Rebuild with:
```bash
nh os switch /etc/nixos -H nixos --ask
```

## Change Shell

Edit `nixos/user.nix`:
```nix
users.users.YOUR_USERNAME.shell = pkgs.zsh;  # or nushell, fish, bash
```

Rebuild and log out/in.

## Troubleshooting

### Build Fails

Check syntax:
```bash
nix flake check
```

Show detailed error:
```bash
sudo nixos-rebuild build --show-trace
```

### Package Not Found

Search for package:
```bash
nix search nixpkgs package-name
```

Or visit: https://search.nixos.org/packages

### Niri Won't Start

Check display manager:
```bash
systemctl status display-manager
```

View logs:
```bash
journalctl -xe
```

## Rollback

If something breaks:

```bash
nh os rollback
```
or
```bash
sudo nixos-rebuild rollback
```

## Useful Commands

```bash
# Update packages
nix flake update

# Check configuration
nix flake check

# Search packages
nix search nixpkgs <name>

# Cleanup old generations
nix-collect-garbage -d
or
nh clean all

# Show NixOS version
nixos-version --detailed

# View logs
journalctl -xe
```

## Next Steps

- See [KEYBINDINGS.md](KEYBINDINGS.md) for Niri shortcuts
- Edit programs in `home/programs/`
- Customize appearance in `home/themes/`
- Modify Niri config in `home/systems/niri/`

---

For help, check [README.md](README.md) or open an issue on GitHub.
