{
  inputs,
  pkgs,
  lib,
  config,
  niri,
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
    package = pkgs.niri;
    # config = ''
    #   environment {
    #     NIXOS_OZONE_WL "1"
    #     MOZ_ENABLE_WAYLAND "1"
    #     XDG_SESSION_TYPE "wayland"
    #     XDG_CURRENT_DESKTOP "niri"
    #     XDG_SESSION_DESKTOP "niri"
    #   }
    #
    #   spawn-at-startup "polkit-gnome-authentication-agent-1"
    #   spawn-at-startup "gnome-keyring-daemon" "--start" "--components=pkcs11,secrets,ssh,pgp"
    #   spawn-at-startup "swaybg" "-m" "fill" "-i" "${config.home.homeDirectory}/.config/nixos/home/themes/wallpapers/MacTahoeDark.jpg"
    #   spawn-at-startup "xwayland-satellite"
    #   spawn-at-startup "hypridle"
    #   spawn-at-startup "wl-paste" "--watch" "cliphist" "store"
    #
    #   cursor {
    #     xcursor-theme "Bibata-Modern-Ice"
    #     xcursor-size 20
    #   }
    #
    #   screenshot-path "~/Pictures/Screenshots/Screenshot_niri_%Y-%m-%d_%H-%M-%S.png"
    #
    #   hotkey-overlay {
    #     skip-at-startup
    #   }
    #
    #   prefer-no-csd
    #
    #   window-rule {
    #     background-effect {
    #       blur true
    #       xray false
    #       noise 0.02
    #       saturation 1.1
    #     }
    #   }
    # '';
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
        { command = ["swaybg" "-m" "fill" "-i" "${config.home.homeDirectory}/.config/nixos/home/themes/wallpapers/Shorekeeper.jpg"]; }
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
