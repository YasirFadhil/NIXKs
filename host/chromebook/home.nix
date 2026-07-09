{ pkgs, config, inputs, lib, ... }: {

  imports = [
    #sys
    ../../home/systems/dankshell
    ../../home/systems/hypr
    ../../home/systems/niri
    # ./systems/noctalia
    ../../home/systems/quickshell
    # ./systems/swaync
    # ./systems/swaylock
    ../../home/systems/waybar

    # programs
    ../../home/programs/fastfetch
    ../../home/programs/foot
    ../../home/programs/ghostty
    ../../home/programs/gnom
    ../../home/programs/helium
    ../../home/programs/nushell
    ../../home/programs/nvchad
    ../../home/programs/rofi
    ../../home/programs/spicetify
    ../../home/programs/starship
    ../../home/programs/zed
    ../../home/programs/zen
    ../../home/programs/zsh

    # other
    ../../home/nh.nix
    ../../home/themes
    ../../home/var.nix
  ];

  home = {
    username = "yasirfadhil";
    homeDirectory = "/home/yasirfadhil";
    stateVersion = "26.05";
    packages = import ./packages.nix { inherit pkgs inputs; };
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      PAGER = "less";
      BROWSER = "zen-browser";
      MOZ_ENABLE_WAYLAND = "1";
      GDK_BACKEND = "wayland,x11";
    };
    file = lib.mkIf (builtins.pathExists (config.home.homeDirectory + "/WhiteSur-firefox-theme")) {
      ".mozila/firefox/Person/chrome" = {
        source = "${config.home.homeDirectory}/WhiteSur-firefox-theme";
        recursive = true;
      };
    };
  };

  programs = {
    firefox = {
      enable = true;
      profiles.Person = {
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "svg.context-properties.content.enabled" = true;
          "browser.tabs.allow_transparent_browser" = true;
        };
      };
    };

    starship = {
      enable = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    git = {
      enable = true;
      settings = {
        user.name = "YasirFadhil";
        user.email = "yasirfadhil46@gmail.com";
      };
    };

    home-manager = {
      enable = true;
    };
  };
}
