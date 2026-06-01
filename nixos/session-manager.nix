{ config, pkgs, lib, inputs, ... }:
{
  services.xserver.enable = true;

  # Use GDM display manager
  # services.displayManager.gdm = {
    # enable = true;
    # wayland = true;
  # };

  # SDDM display manager
  services.displayManager.sddm = {
    enable = true;
    theme = "sddm-astronaut-theme";

    extraPackages = [
      pkgs.sddm-astronaut
      (pkgs.sddm-astronaut.override {
        embeddedTheme = "pixel_sakura"; # Options: "astronaut", "black_hole", "cyberpunk", etc.
      })
    ];
  };

  # Enable the GNOME Desktop Environment.
  services.desktopManager.gnome.enable = true;
  services.gnome.gnome-keyring.enable = true;
  # Additional GNOME optimization (optional)
  environment.gnome.excludePackages = with pkgs; [
    # Remove if you want to keep these
    gnome-tour
    epiphany
    geary
    evince
  ];
  services.gvfs.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
    model = "chromebook";
  };

  # Portal configuration for Wayland
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
    ];
    config.common.default = "gnome";
  };

  # PAM configuration for swaylock
  security.pam.services.swaylock = {};

  # PAM configuration for hyprlock
  security.pam.services.hyprlock = {};

  # Enable systemd user services in PAM
  security.pam.services.gdm.enableGnomeKeyring = true;
}
