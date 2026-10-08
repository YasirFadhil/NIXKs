{
  pkgs,
  config,
  ...
}: let
  username = config.var.username;
in {
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
      enable = true;
    };

    # Ly Greeter
    ly = {
      enable = false;
    };

    # Cosmic greeter
    cosmic-greeter = {
      enable = false;
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
  services.desktopManager.gnome.enable = false;
  services.gnome.gnome-keyring.enable = true;
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  programs.dconf.enable = true;
  services.desktopManager.cosmic.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;

      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

      CPU_MAX_PERF_ON_AC = 100;
      CPU_MAX_PERF_ON_BAT = 70;
    };
  };

  # 2. Izin Sudo Tanpa Password untuk Quickshell

  # Portal configuration for Wayland
  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [
  #     pkgs.xdg-desktop-portal-gnome
  #   ];
  #   config.common.default = "gnome";
  # };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];

    config = {
      common = {
        default = ["hyprland" "gtk"];
      };

      hyprland = {
        default = ["hyprland" "gtk"];
        "org.freedesktop.impl.portal.Settings" = ["gtk"];
      };
    };
  };

  # PAM configuration for swaylock
  security.pam.services.swaylock = {};

  # PAM configuration for hyprlock
  security.pam.services.hyprlock = {};

  # Enable systemd user services in PAM
  security.pam.services.gdm.enableGnomeKeyring = true;
  security.polkit.enable = true;

  security.sudo.extraRules = [
    {
      users = ["${config.var.username}"];
      commands = [
        {
          command = "${pkgs.coreutils}/bin/tee";
          options = ["NOPASSWD"];
        }
        {
          command = "${pkgs.tlp}/bin/tlp";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];
}
