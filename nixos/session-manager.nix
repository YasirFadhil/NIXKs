{ pkgs, ... }:
{
  # Xserver
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
      model = "chromebook";
    };
  };

  # Display Manager
  services.displayManager = {
    # GDM
    gdm = {
      enable = false;
    };

    # Ly Greeter
    ly = {
      enable = false;
    };
    
    # Cosmic greeter
    cosmic-greeter = {
      enable = true;
    };

    # SDDM
    sddm = {
      enable = false;
      theme = "sddm-astronaut-theme";

      extraPackages = [
        pkgs.sddm-astronaut
        (pkgs.sddm-astronaut.override {
          embeddedTheme = "pixel_sakura";
         })
      ];
    };
  };

  # Enable the GNOME Desktop Environment.
  services.desktopManager.gnome.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.gvfs.enable = true;

  services.desktopManager.cosmic.enable = true;

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
