{ 
  pkgs, 
  inputs, 
  config, 
  ... 
}: 

{

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
    username = config.var.username;
    homeDirectory = "/home/${config.var.username}";
    stateVersion = "26.05";
    packages = import ../../home/packages.nix { inherit pkgs inputs; };
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      PAGER = "less";
      BROWSER = "helium";
      MOZ_ENABLE_WAYLAND = "1";
      GDK_BACKEND = "wayland,x11";
    };
  };

  programs = {
    firefox = {
      enable = true;
    };

    starship = {
      enable = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    zsh = {
      enable = true;
    };

    git = {
      enable = true;
      settings = {
        user.name = config.var.git.username;
        user.email = config.var.git.email;
      };
    };

    home-manager = {
      enable = true;
    };
  };
}
