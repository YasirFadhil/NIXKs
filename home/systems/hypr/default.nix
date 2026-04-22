{ pkgs, config, inputs, ... }:

let
  myPackages = import ../../packages.nix { inherit pkgs; };
in

{
  imports = [
    ./modules/animation.nix
    ./modules/hyprlock.nix
    ./modules/hypridle.nix
    ./modules/keybinds.nix
  ];
  waybar.enable = true;
  wayland.windowManager.hyprland = {
    enable = false;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    settings = {
      exec-once = [
        "waybar"
        # "noctalia-shell"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 2;
          vibrancy = 0.1696;
        };
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
      };

      input = {
        kb_layout = "us";
        kb_model = "chromebook";
        follow_mouse = 1;
        sensitivity = 0.0;
        touchpad = {
          natural_scroll = true;
        };
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # windowrule = [
      #   "float,^(pavucontrol)$"
      #   "float,^(blueman-manager)$"
      # ];
    };
  };
}
