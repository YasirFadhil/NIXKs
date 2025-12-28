{ pkgs, lib, config, inputs, ... }:

let
  mactahoe-icon-theme = pkgs.callPackage ../icons/mactahoe.nix {};
in
{
  # GTK theme configuration
  gtk = {
    enable = true;
    theme = {
      name = "WhiteSur-Dark";
      package = pkgs.whitesur-gtk-theme;
    };
    font = {
      name = "SF Pro Display";
      size = 11;
    };
    iconTheme = {
      name = "MacTahoe-dark";
      package = mactahoe-icon-theme;
      # name = "WhiteSur-dark";
      # package = pkgs.whitesur-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 20;
    };
  };
}
