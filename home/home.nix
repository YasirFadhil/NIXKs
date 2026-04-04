{ pkgs, config, inputs, lib, ... }: {

  imports = [
    #sys
    ./systems/dankshell
    ./systems/hypr
    ./systems/niri
    ./systems/noctalia
    # ./systems/swaync
    # ./systems/waybar

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

  # waybar.enable = true;
  programs.starship = {
    enable = true;
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
