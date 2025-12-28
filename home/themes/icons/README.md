# MacTahoe Icon Theme - NixOS Installation Guide

## 📦 Package Information

MacTahoe icon theme telah berhasil dipackage untuk NixOS!

**Source**: https://github.com/vinceliuice/MacTahoe-icon-theme
**License**: GPL-3.0
**Status**: ✅ Ready to use

---

## 🚀 Quick Start

Icon theme sudah dikonfigurasi di GTK config. Untuk mengaktifkan:

```bash
sudo nixos-rebuild switch
```

---

## 🎨 Available Variants

MacTahoe icon theme memiliki 3 varian utama yang sudah terinstall:

1. **MacTahoe** (default/blue) - Tema utama dengan aksen biru
2. **MacTahoe-light** - Varian light/terang
3. **MacTahoe-dark** - Varian dark/gelap

### Varian Warna Lainnya

Jika ingin install varian warna lain, edit `/etc/nixos/home/themes/icons/mactahoe.nix`:

```nix
installPhase = ''
  # ... existing code ...
  
  # Uncomment untuk install varian warna lain:
  bash install.sh -d $out/share/icons -n MacTahoe -t purple
  bash install.sh -d $out/share/icons -n MacTahoe -t pink
  bash install.sh -d $out/share/icons -n MacTahoe -t red
  bash install.sh -d $out/share/icons -n MacTahoe -t orange
  bash install.sh -d $out/share/icons -n MacTahoe -t yellow
  bash install.sh -d $out/share/icons -n MacTahoe -t green
  bash install.sh -d $out/share/icons -n MacTahoe -t grey
  
  # ...
'';
```

---

## ⚙️ Configuration

Icon theme dikonfigurasi di `/etc/nixos/home/themes/gtk/default.nix`:

```nix
gtk = {
  iconTheme = {
    name = "MacTahoe-dark";  # atau "MacTahoe" atau "MacTahoe-light"
    package = mactahoe-icon-theme;
  };
};
```

### Ganti Varian

Ubah `name` sesuai varian yang diinginkan:

```nix
# Untuk dark theme
name = "MacTahoe-dark";

# Untuk light theme
name = "MacTahoe-light";

# Untuk default (blue)
name = "MacTahoe";

# Untuk varian warna lain (jika sudah diinstall)
name = "MacTahoe-purple";
name = "MacTahoe-pink";
name = "MacTahoe-red";
name = "MacTahoe-orange";
name = "MacTahoe-yellow";
name = "MacTahoe-green";
name = "MacTahoe-grey";
```

---

## 🖥️ Bold Version (untuk 4K Display)

Jika kamu punya 4K display dengan scale 200%, gunakan bold version:

Edit `/etc/nixos/home/themes/icons/mactahoe.nix`:

```nix
installPhase = ''
  # Ganti ini:
  bash install.sh -d $out/share/icons -n MacTahoe -t default
  
  # Dengan ini (tambah -b flag):
  bash install.sh -d $out/share/icons -n MacTahoe -t default -b
'';
```

---

## 📂 File Structure

```
/etc/nixos/home/themes/icons/
├── mactahoe.nix       # Package derivation
├── default.nix        # Package wrapper
└── README.md          # Documentation (this file)

~/.local/share/icons/  # Icons installed here (via home-manager)
├── MacTahoe/
├── MacTahoe-light/
└── MacTahoe-dark/
```

---

## 🔧 Troubleshooting

### Icon theme tidak apply setelah rebuild

1. Logout dan login kembali
2. Atau restart display manager:
   ```bash
   sudo systemctl restart display-manager
   ```

### Icon tidak muncul di aplikasi tertentu

Beberapa aplikasi (terutama Flatpak/Snap) membutuhkan konfigurasi tambahan:

```bash
# Untuk Flatpak
flatpak override --user --filesystem=~/.local/share/icons:ro
flatpak override --user --filesystem=~/.icons:ro

# Atau per-app
flatpak override --user com.app.name --filesystem=~/.local/share/icons:ro
```

### GTK theme tidak detect icon theme

Pastikan GTK cache sudah update:

```bash
gtk-update-icon-cache -f -t ~/.local/share/icons/MacTahoe-dark
```

### Rebuild icon theme package

Jika perlu rebuild package (misalnya ada update):

```bash
# Test build
nix-build -E 'with import <nixpkgs> {}; callPackage ./home/themes/icons/mactahoe.nix {}'

# Rebuild system
sudo nixos-rebuild switch
```

---

## 🎯 Integration dengan Theme Lain

MacTahoe icon theme cocok dengan:

### GTK Themes
- **WhiteSur-gtk-theme** (currently used)
- **MacTahoe-gtk-theme**: https://github.com/vinceliuice/MacTahoe-gtk-theme
- Orchis
- Qogir

### Cursor Themes
- **Bibata-Modern-Ice** (currently used)
- MacTahoe-cursor (available in main repo)

---

## 🔄 Update Icon Theme

Untuk update ke versi terbaru:

1. Get latest hash:
   ```bash
   nix-prefetch-url --unpack https://github.com/vinceliuice/MacTahoe-icon-theme/archive/main.tar.gz
   ```

2. Update hash di `mactahoe.nix`:
   ```nix
   sha256 = "new-hash-here";
   ```

3. Rebuild:
   ```bash
   sudo nixos-rebuild switch
   ```

---

## 💡 Tips

1. **Konsistensi**: Gunakan MacTahoe-dark jika GTK theme dark, MacTahoe-light jika GTK theme light

2. **Preview**: Gunakan `lxappearance` atau `nwg-look` untuk preview icon theme sebelum apply

3. **Custom Icons**: Letakkan custom icons di `~/.local/share/icons/MacTahoe-dark/` (akan override default)

4. **Folder Colors**: MacTahoe support custom folder colors via scripts di repo aslinya

---

## 📚 References

- **Upstream**: https://github.com/vinceliuice/MacTahoe-icon-theme
- **GTK Icon Theme Spec**: https://specifications.freedesktop.org/icon-theme-spec/
- **NixOS Icon Theme Options**: https://nix-community.github.io/home-manager/options.html#opt-gtk.iconTheme

---

## ✅ Current Configuration

```nix
# /etc/nixos/home/themes/gtk/default.nix
gtk.iconTheme = {
  name = "MacTahoe-dark";
  package = mactahoe-icon-theme;
};
```

**Status**: ✅ Configured and ready to use!

---

**Last Updated**: 2024
**Packager**: NixOS User
**Build Status**: ✅ Successful