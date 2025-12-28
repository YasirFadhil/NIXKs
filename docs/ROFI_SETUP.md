# Rofi Configuration Setup Guide

## Overview
This guide explains how to integrate the new Rofi configuration into your NixOS home-manager setup. Rofi is a powerful application launcher and utility menu system with support for emoji picking, clipboard management, and power controls.

## What You've Got

Your rofi setup includes:
- **Application Launcher (drun)** - Quick app search with icons
- **Command Runner (run)** - Execute shell commands
- **Emoji Picker** - 100+ built-in emojis, copy to clipboard
- **Clipboard Manager** - Access clipboard history via cliphist
- **Power Menu** - Shutdown, reboot, sleep, logout
- **Two Themes** - Custom dark and light themes included

## Integration Steps

### Step 1: Add Rofi to home.nix imports

Edit `/etc/nixos/home/home.nix` and add the rofi module to the imports list:

```nix
{ pkgs, config, inputs, lib, ... }: {

  imports = [
    #sys
    ./systems/hypr
    ./systems/niri
    ./systems/swaync
    ./systems/waybar

    # programs
    ./programs/fastfetch
    ./programs/ghostty
    ./programs/nushell
    ./programs/spicetify
    ./programs/starship
    ./programs/zen
    ./programs/rofi        # ADD THIS LINE

    # other
    ./nh.nix
    ./themes
    ./var.nix
  ];

  # ... rest of your config
}
```

### Step 2: Rebuild Home-Manager

```bash
home-manager switch
```

This will:
- Create all rofi configuration files
- Set up scripts in `~/.config/rofi/scripts/`
- Generate themes in `~/.config/rofi/themes/`
- Create emoji database in `~/.config/rofi/emoji-list.txt`

### Step 3: Add Keybindings to Your Window Manager

#### For Hyprland

Edit `~/.config/hypr/hyprland.conf` (or your hyprland config) and add:

```conf
# Rofi keybindings
bind = $mainMod, d, exec, rofi -show drun
bind = $mainMod SHIFT, d, exec, rofi -show run
bind = $mainMod, e, exec, ~/.config/rofi/scripts/emoji.sh
bind = $mainMod, c, exec, ~/.config/rofi/scripts/clipboard.sh
bind = $mainMod SHIFT, p, exec, ~/.config/rofi/scripts/power-menu.sh
```

#### For Sway

Edit `~/.config/sway/config` and add:

```conf
# Rofi keybindings
bindsym $mod+d exec rofi -show drun
bindsym $mod+shift+d exec rofi -show run
bindsym $mod+e exec ~/.config/rofi/scripts/emoji.sh
bindsym $mod+c exec ~/.config/rofi/scripts/clipboard.sh
bindsym $mod+shift+p exec ~/.config/rofi/scripts/power-menu.sh
```

#### For Niri

Edit your niri `config.yaml` and add under `binds:`:

```yaml
binds:
  - action:
      spawn: ["rofi", "-show", "drun"]
    key: "Super+D"
  - action:
      spawn: ["rofi", "-show", "run"]
    key: "Super+Shift+D"
  - action:
      spawn: ["$HOME/.config/rofi/scripts/emoji.sh"]
    key: "Super+E"
  - action:
      spawn: ["$HOME/.config/rofi/scripts/clipboard.sh"]
    key: "Super+C"
  - action:
      spawn: ["$HOME/.config/rofi/scripts/power-menu.sh"]
    key: "Super+Shift+P"
```

### Step 4: Initialize Rofi (Optional but Recommended)

Run the initialization script:

```bash
bash ~/.config/rofi/init-rofi.sh
```

This will create necessary directories and confirm setup.

## Verification

Test that everything works:

```bash
# Test app launcher
rofi -show drun

# Test command runner
rofi -show run

# Test emoji picker
~/.config/rofi/scripts/emoji.sh

# Test clipboard (copy something first)
~/.config/rofi/scripts/clipboard.sh

# Test power menu
~/.config/rofi/scripts/power-menu.sh
```

## File Structure

After setup, you'll have:

```
~/.config/rofi/
├── config.rasi                    # Main configuration
├── scripts/
│   ├── emoji.sh                  # Emoji picker
│   ├── clipboard.sh              # Clipboard manager
│   └── power-menu.sh             # Power menu
├── themes/
│   ├── custom-dark.rasi          # Dark theme
│   └── custom-light.rasi         # Light theme
├── emoji-list.txt                # Emoji database
├── init-rofi.sh                  # Setup script
├── QUICK_START.md                # Quick reference
├── keybindings.md                # Keybinding reference
└── README.md                     # Full documentation
```

## Configuration Locations

- **System config**: `/etc/nixos/home/programs/rofi/default.nix`
- **Themes config**: `/etc/nixos/home/programs/rofi/theme.nix`
- **Integration setup**: `/etc/nixos/home/programs/rofi/integration.nix`
- **User config**: `~/.config/rofi/config.rasi` (auto-managed)

## Quick Reference

### Keybindings

**In Rofi:**
- `Tab` / `Ctrl+N` - Next item
- `Shift+Tab` / `Ctrl+P` - Previous item
- `Ctrl+A` - First item
- `Ctrl+E` - Last item
- `Ctrl+U` - Clear search
- `Return` - Select item
- `Alt+Left` / `Ctrl+Shift+Tab` - Previous mode
- `Alt+Right` / `Ctrl+Tab` - Next mode
- `Escape` - Exit

### Search Tips

- **Fuzzy matching**: Type `vsc` to find "Visual Studio Code"
- **Negate**: Type `-terminal` to hide apps with "terminal" in name
- **Case-insensitive**: By default, searches ignore case
- **Sorted by**: Frequency of use, then alphabetically

## Customization

### Change Theme

Edit `/etc/nixos/home/programs/rofi/default.nix`:

```nix
programs.rofi = {
  enable = true;
  package = pkgs.rofi-wayland;
  theme = "custom-dark";  # or "custom-light"
```

Then rebuild:
```bash
home-manager switch
```

### Add Custom Emojis

Edit `~/.config/rofi/emoji-list.txt` and add lines in format:
```
emoji description
😀 grinning
🎮 game
🚀 rocket
```

### Modify Colors

Edit theme files in `~/.config/rofi/themes/custom-dark.rasi` or `custom-light.rasi`:

```rasi
* {
  bg0:     #1e1e2e;     # Background color
  accent:  #61afef;     # Accent color
  fg0:     #abb2bf;     # Text color
}
```

## Clipboard Manager Setup

For clipboard manager to work properly:

1. **Ensure cliphist is running** - It tracks clipboard history
2. **Copy some items** - Rofi clipboard shows your history
3. **Optional**: Add cliphist to your startup

For Hyprland, add to your config:
```conf
exec-once = cliphist wl-paste | cliphist store
```

## Troubleshooting

### Rofi doesn't launch
```bash
# Check if rofi-wayland is installed
which rofi

# Verify installation
nix-shell -p rofi-wayland
rofi -version
```

### Icons not showing
```bash
# Update GTK icon cache
gtk-update-icon-cache ~/.local/share/icons/*

# Check icon theme is installed
ls ~/.local/share/icons/
```

### Emoji picker doesn't copy
```bash
# Test clipboard
echo "test" | wl-copy
wl-paste

# Check notification daemon
systemctl --user status dunst
```

### Clipboard manager empty
```bash
# Check cliphist history
cliphist list

# Restart cliphist
pkill cliphist
cliphist wl-paste | cliphist store &
```

## Advanced Configuration

### Add Custom Modes

Edit `/etc/nixos/home/programs/rofi/default.nix` and modify:

```nix
extraConfig = {
  modes = "drun,run,emoji,clipboard,custom-mode";
};
```

### Modify Window Size

In the theme files, adjust:

```rasi
window {
  width: 60%;        # Change window width
  height: 50%;       # Change window height
  x-offset: 0;       # Horizontal offset
  y-offset: 0;       # Vertical offset
}
```

### Performance Tuning

For better performance on slower systems:

```nix
extraConfig = {
  lines = 8;         # Show fewer items
  columns = 1;       # Single column
  matching = "glob"; # Faster matching
};
```

## Getting Help

Full documentation available at:
- `~/.config/rofi/README.md` - Complete guide
- `~/.config/rofi/QUICK_START.md` - Quick reference
- `~/.config/rofi/keybindings.md` - Keybinding reference
- [Rofi GitHub](https://github.com/davatorium/rofi)

## Next Steps

1. Add rofi import to `home.nix`
2. Run `home-manager switch`
3. Add keybindings to your WM config
4. Test each function (launcher, emoji, clipboard, power)
5. Customize colors and appearance as desired
