{
  inputs,
  pkgs,
  lib,
  config,
  niri-blur,
  ...
}:

let
  myPackages = import ../../packages.nix { inherit pkgs; };
  # noctalia = cmd: [
  #   "noctalia-shell" "ipc" "call"
  # ] ++ (pkgs.lib.splitString " " cmd);
in
{
  imports = [
    inputs.niri.homeModules.niri
    ./modules/animations.nix
    ./modules/input.nix
    ./modules/keybind.nix
    ./modules/layout.nix
    ./modules/output.nix
    ./modules/window-rule.nix
  ];

  home.packages = myPackages;

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 20;
    x11.enable = true;
    gtk.enable = true;
  };

  programs.niri = {
    enable = true;

    settings = {
      # Environment variables
      environment = {
        NIXOS_OZONE_WL = "1";
        MOZ_ENABLE_WAYLAND = "1";
        XDG_SESSION_TYPE = "wayland";
        XDG_CURRENT_DESKTOP = "niri";
        XDG_SESSION_DESKTOP = "niri";
      };

      # Spawn at startup
      spawn-at-startup = [
        { command = ["polkit-gnome-authentication-agent-1"]; }
        { command = ["gnome-keyring-daemon" "--start" "--components=pkcs11,secrets,ssh,pgp"]; }
        { command = ["swaybg" "-m" "fill" "-i" "/etc/nixos/home/themes/wallpapers/macos-tahoe-26-5120x2880-22674.jpg"]; }
        { command = ["xwayland-satellite"]; }
        { command = ["hypridle"]; }
        { command = ["wl-paste" "--watch" "cliphist" "store"]; }
      ];

      # Cursor settings
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 20;
      };

      # Screenshot settings
      screenshot-path = "~/Pictures/Screenshots/Screenshot_niri_%Y-%m-%d_%H-%M-%S.png";

      # Hotkey daemon
      hotkey-overlay = {
        skip-at-startup = true;
      };

      # Prefer no CSD
      prefer-no-csd = true;
    };
  };
}

