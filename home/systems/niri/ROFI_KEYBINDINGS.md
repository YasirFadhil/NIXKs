# Rofi Keybindings for Niri

Quick reference for all Rofi keybindings integrated with Niri.

## 🎯 Main Rofi Menus

| Keybinding | Function | Description |
|------------|----------|-------------|
| `Super+D` | Application Launcher | Open drun menu to launch applications |
| `Super+Shift+D` | Run Command | Execute custom commands |
| `Super+E` | Emoji Picker | Select and copy emoji to clipboard |
| `Super+Shift+C` | Clipboard Manager | Access clipboard history |
| `Super+Slash` | Web Search | Search the web (Google) |

## ⚡ Utility Scripts

| Keybinding | Function | Description |
|------------|----------|-------------|
| `Super+Shift+P` | Power Menu | Shutdown, Reboot, Suspend, Logout |
| `Super+Shift+W` | Wallpaper Picker | Select and apply wallpaper |
| `Super+Alt+P` | Power Profiles | Switch power profile (Performance/Balanced/Power Saver) |
| `Super+Alt+N` | WiFi Networks | Connect to WiFi networks |

## 📚 Reference

| Keybinding | Function | Description |
|------------|----------|-------------|
| `Super+Shift+Slash` | Keybinds Reference | Display all system keybindings |

## 🚀 Quick Start

### Launching Applications
```bash
Super+D       # Open app launcher
Super+Shift+D # Run custom command
```

### Managing System
```bash
Super+Shift+P  # Power menu (shutdown, reboot, suspend)
Super+Shift+L  # Lock screen
Super+Shift+O  # Logout menu (wlogout)
```

### Utilities
```bash
Super+E        # Emoji picker
Super+Slash    # Web search
Super+Shift+C  # Clipboard history
Super+Shift+W  # Wallpaper picker
Super+Alt+P    # Power profiles
Super+Alt+N    # WiFi networks
```

## 🎨 Custom Themes Available

Each Rofi menu uses a customized theme:

- **Power Menu** - Compact (200px)
- **Emoji Picker** - Grid layout (500px, 5 columns)
- **Clipboard** - Wide format (400px)
- **Web Search** - Standard size (600px)
- **Wallpaper Picker** - Grid preview (600px, 3 columns)
- **Power Profiles** - Minimal (250px)
- **WiFi Networks** - Standard size (600px)

## ⌨️ Rofi Navigation (While Open)

### Movement
- `Arrow Up/Down` or `Ctrl+K/J` - Navigate items
- `Tab` - Autocomplete
- `Enter` - Select item

### Editing
- `Ctrl+H` - Clear input
- `Ctrl+U` - Clear line
- `Ctrl+W` - Clear word
- `Escape` - Close menu

## 🔧 Configuration

All Rofi settings are located in:
```bash
~/.config/rofi/
├── config.rasi                    # Main configuration
└── custom-rofi/
    ├── config-powermenu.rasi
    ├── config-emoji.rasi
    ├── config-clipboard.rasi
    ├── config-search.rasi
    ├── config-wallpaper.rasi
    ├── config-power-profiles.rasi
    └── ...
```

## 📍 Script Locations

All scripts are in `~/.local/bin/`:
```bash
~/.local/bin/rofi-powermenu
~/.local/bin/rofi-emoji
~/.local/bin/rofi-clipboard
~/.local/bin/rofi-keyhints
~/.local/bin/rofi-power-profiles
~/.local/bin/rofi-wallpicker
~/.local/bin/rofi-search
~/.local/bin/rofi-wifi
```

## 💡 Tips

### Emoji Picker
1. Press `Super+E`
2. Type emoji name (e.g., "smile", "heart")
3. Select emoji
4. Emoji is automatically copied to clipboard
5. Paste with `Ctrl+V`

### Power Menu
1. Press `Super+Shift+P`
2. Select option:
   - **Shutdown** - Power off system
   - **Reboot** - Restart system
   - **Suspend** - Sleep mode
   - **Logout** - Close current session

### Wallpaper Picker
1. Ensure wallpapers are in `~/.local/share/wallpapers/`
2. Press `Super+Shift+W`
3. Select wallpaper from list
4. Wallpaper changes immediately

### Clipboard Manager
1. Press `Super+Shift+C`
2. Search recent clipboard entries
3. Select to paste

### Power Profiles
1. Press `Super+Alt+P`
2. Choose profile:
   - **Performance** - Max performance, more power usage
   - **Balanced** - Balanced performance and power
   - **Power Saver** - Max battery life

## 🔄 Managing Multiple Rofi Instances

Rofi is single-instance by default. Opening another menu closes the previous one.

To use multiple at once, create new configs with different instance names.

## 🎯 Workflow Example

**Morning Setup:**
```bash
Super+Shift+P    # Select Balanced power profile
Super+Shift+W    # Set wallpaper
Super+D          # Open app launcher
```

**Daily Use:**
```bash
Super+D          # Launch app
Super+E          # Use emoji in message
Super+Slash      # Quick web search
Super+Shift+C    # Paste from clipboard
```

**Shutdown:**
```bash
Super+Shift+P    # Power menu
↓ Select Shutdown
```

## 📖 More Information

- Full Rofi documentation: `/etc/nixos/home/rofi/README.md`
- Niri configuration: `/etc/nixos/home/systems/niri/default.nix`
- All rofi scripts are in: `/etc/nixos/home/programs/rofi/default.nix`

## 🆘 Troubleshooting

### Scripts not working
```bash
# Check if scripts are executable
ls -la ~/.local/bin/rofi-*

# Make them executable
chmod +x ~/.local/bin/rofi-*
```

### Config not loading
```bash
# Check config file
cat ~/.config/rofi/config.rasi

# Verify theme files exist
ls ~/.config/rofi/custom-rofi/
```

### Emoji picker not working
```bash
# Ensure emoji file exists
mkdir -p ~/.local/share/rofi
# emoji data will be created on first run
```

### Wallpaper picker not working
```bash
# Create wallpaper directory
mkdir -p ~/.local/share/wallpapers
# Copy wallpapers to this directory
cp /path/to/wallpapers/* ~/.local/share/wallpapers/
```

## 🎉 Enjoy!

Rofi is fully integrated with Niri. Happy launching!

---

**Last Updated**: 2024
**Rofi Version**: Latest
**Niri Integration**: Complete