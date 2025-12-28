# Niri Keybindings Reference

## Overview

NIXKs uses **Niri**, a modern Wayland compositor. All keybindings use `Super` (Windows key) as the modifier.

Press `Super + Shift + /` to see the keybindings overlay in Niri.

## Navigation & Movement

### Focus Navigation
| Keybinding | Action |
|-----------|--------|
| `Super + H` / `Super + Left` | Focus column to the left |
| `Super + L` / `Super + Right` | Focus column to the right |
| `Super + K` / `Super + Up` | Focus window above |
| `Super + J` / `Super + Down` | Focus window below |

### Moving Windows
| Keybinding | Action |
|-----------|--------|
| `Super + Ctrl + H` | Move column left |
| `Super + Ctrl + L` | Move column right |
| `Super + Ctrl + K` | Move window up |
| `Super + Ctrl + J` | Move window down |

## Workspaces

### Switch Workspaces
| Keybinding | Action |
|-----------|--------|
| `Super + 1-9` | Switch to workspace 1-9 |
| `Super + 0` | Switch to workspace 10 |
| `Super + -` | Switch to scratchpad |

### Move to Workspaces
| Keybinding | Action |
|-----------|--------|
| `Super + Shift + 1-9` | Move column to workspace 1-9 |
| `Super + Shift + 0` | Move column to workspace 10 |
| `Super + Shift + -` | Move window to scratchpad |

## Window Management

| Keybinding | Action |
|-----------|--------|
| `Super + Q` | Close window |
| `Super + F` | Maximize column |
| `Super + Shift + F` | Fullscreen window |
| `Super + Alt + F` | Toggle floating |
| `Super + R` | Switch preset column width |
| `Super + Shift + R` | Reset window height |

## Applications

| Keybinding | Action |
|-----------|--------|
| `Super + T` | Open Ghostty terminal |
| `Super + D` | Open application launcher (Rofi drun) |
| `Super + Shift + D` | Open run launcher (Rofi run) |
| `Super + E` | Open file manager (Nautilus) |
| `Super + Alt + V` | Open volume control (PulseAudio) |

## Rofi Utilities

| Keybinding | Action |
|-----------|--------|
| `Super + Shift + E` | Open emoji picker |
| `Super + Shift + V` | Open clipboard manager |

## Media & System

### Audio Control
| Keybinding | Action |
|-----------|--------|
| `XF86AudioRaiseVolume` | Increase volume by 5% |
| `XF86AudioLowerVolume` | Decrease volume by 5% |
| `XF86AudioMute` | Toggle mute |

### Brightness Control
| Keybinding | Action |
|-----------|--------|
| `XF86MonBrightnessUp` | Increase brightness by 5% |
| `XF86MonBrightnessDown` | Decrease brightness by 5% |

### Screenshots
| Keybinding | Action |
|-----------|--------|
| `Super + Shift + S` | Screenshot area |
| `Super + S` | Screenshot screen |
| `Super + Alt + S` | Screenshot window |

## System Control

| Keybinding | Action |
|-----------|--------|
| `Super + A` | Open workspace overview |
| `Super + P` | Open power menu (wlogout) |
| `Super + Shift + P` | Turn off monitors |
| `Super + Shift + L` | Lock session |
| `Super + Shift + Q` | Quit Niri |
| `Super + Shift + /` | Show keybindings overlay |

## Customization

To customize keybindings, edit `home/systems/niri/default.nix`:

```nix
binds = {
  "Super+T".action.spawn = "ghostty";  # Custom command
  "Super+Custom".action.close-window = {};  # New keybinding
  # Add more as needed
};
```

### Common Actions
- `spawn` - Launch application
- `close-window` - Close current window
- `maximize-column` - Maximize column width
- `fullscreen-window` - Make window fullscreen
- `focus-column-left` - Focus left column
- `move-column-left` - Move column left
- `focus-workspace` - Switch workspace
- `move-column-to-workspace` - Move to workspace
- `screenshot` - Take area screenshot
- `power-off-monitors` - Turn off displays
- `quit` - Exit Niri

## Tips

1. **Workspaces** - Use numbers 1-9 for organized workflow
2. **Scratchpad** - Use `Super + -` for quick access to hidden windows
3. **Floating** - Toggle floating with `Super + Alt + F` for special windows
4. **Launcher** - `Super + D` for GUI apps, `Super + Shift + D` for commands
5. **Overview** - `Super + A` to see all workspaces and windows

## Modify Keybindings

Edit `home/systems/niri/default.nix` in the `binds` section:

```nix
binds = {
  # Change terminal
  "Super+T".action.spawn = "alacritty";  # Replace ghostty
  
  # Add new keybinding
  "Super+B".action.spawn = "firefox";
  
  # Remove keybinding by commenting it out
  # "Super+D".action.spawn = ["rofi" "-show" "drun"];
};
```
---

For Niri documentation, see: https://github.com/YaLTeR/niri
