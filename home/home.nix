{ pkgs, config, inputs, lib, ... }: {

  imports = [
    #sys
    ./systems/hypr
    ./systems/niri
    ./systems/swaync
    ./systems/waybar

    # programs
    ./programs/fastfetch
    ./programs/ghostty
    ./programs/nushell
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
  home.packages = import ./packages.nix {inherit pkgs;};

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
