{ pkgs, config, inputs, lib, ... }: {

  imports = [
    #sys
    # ./systems/dankshell
    ./systems/hypr
    ./systems/niri
    # ./systems/noctalia
    ./systems/swaync
    ./systems/waybar

    # programs
    ./programs/fastfetch
    ./programs/foot
    ./programs/ghostty
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

  home.username = "yasirfadhil";
  home.homeDirectory = "/home/yasirfadhil";
  home.stateVersion = "24.11";
  home.packages = import ./packages.nix { inherit pkgs inputs; };
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    PAGER = "less";
    BROWSER = "zen-browser";
    MOZ_ENABLE_WAYLAND = "1";
    GDK_BACKEND = "wayland,x11";
  };

  waybar.enable = true;
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
