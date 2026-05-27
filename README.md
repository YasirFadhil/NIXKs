# NIXKs

<div align="center">
  <img src="https://wiki.nixos.org/w/images/a/a1/Nix-snowflake-colours.svg" width="120" alt="NixOS Logo" />

Minimal and modular NixOS configuration using Flakes, Home Manager, and the Niri compositor.
Built for a clean Wayland workflow with a macOS-inspired aesthetic.
</div>

---

## Overview

NIXKs is my personal NixOS setup focused on:

- Declarative and reproducible configuration
- Modular system structure
- Wayland-first desktop experience
- Lightweight but modern workflow
- Easy customization and maintenance

This setup currently uses:

- [NixOS](https://nixos.org/)
- [Flakes](https://nixos.wiki/wiki/Flakes)
- [Home Manager](https://github.com/nix-community/home-manager)
- [Niri](https://github.com/YaLTeR/niri)
- [DMS](https://github.com/AvengeMedia/DankMaterialShell)

---

## Documentation

| File | Description |
|------|-------------|
| [INSTALL.md](INSTALL.md) | Installation and setup guide |
| [KEYBINDINGS.md](KEYBINDINGS.md) | Niri keybindings reference |

---

## Directory Structure

```txt
.
├── flake.nix
├── host/
│   └── chromebook/
├── nixos/
├── home/
│   ├── programs/
│   ├── systems/
│   ├── themes/
│   └── scripts/
└── README.md
```

---

## Features

- Modular NixOS configuration
- Home Manager integration
- Niri compositor setup
- Reusable theming system
- Multiple shell configurations
- Custom scripts and utilities
- Chromebook-friendly setup

---

## Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager](https://nix-community.github.io/home-manager/)
- [Niri Wiki](https://github.com/YaLTeR/niri/wiki)
- [NixOS Wiki](https://nixos.wiki/)
- [DMS](https://github.com/AvengeMedia/DankMaterialShell)

---

## License

This project is licensed under the MIT License.

---

<div align="center">
Made by <a href="https://github.com/YasirFadhil">YasirFadhil</a>
</div>
