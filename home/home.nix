{ pkgs, config, inputs, lib, ... }: {

  imports = [
    #sys
    ./systems/dankshell
    ./systems/hypr
    ./systems/niri
    # ./systems/noctalia
    ./systems/quickshell
    # ./systems/swaync
    ./systems/waybar

    # programs
    ./programs/fastfetch
    ./programs/foot
    ./programs/ghostty
    ./programs/gnom
    ./programs/nushell
    ./programs/nvchad
    ./programs/rofi
    ./programs/spicetify
    ./programs/starship
    ./programs/zed
    ./programs/zen
    ./programs/zsh

    # other
    ./nh.nix
    ./themes
    ./var.nix
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
  };

  #xdg.mimeApps = {
  #  enable = true;
  #  defaultApplications = {
  #    "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
  #  };
  #};


  # waybar.enable = true;
  programs.starship = {
    enable = true;
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.git = {
    enable = true;
    settings = {
      user.name = "YasirFadhil";
      user.email = "yasirfadhil46@gmail.com";
    };
  };

  programs.home-manager.enable = true;
}
