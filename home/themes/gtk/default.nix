{ pkgs, lib, config, inputs, ... }:

let
  mactahoe-icon-theme = pkgs.callPackage ../icons/mactahoe.nix {};
  gnome-macos-tahoe-theme = pkgs.callPackage ./gnome-macos-tahoe.nix {};
in
{
  # GTK theme configuration
  gtk = {
    enable = true;
    theme = {
      name = "Tahoe-Dark";
      package = gnome-macos-tahoe-theme;
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
      # name = "Bibata-Modern-Ice";
      # package = pkgs.bibata-cursors;
      name = "MacTahoe-dark";
      size = 24;
    };
    gtk4 = {
      theme = {
        name = "Tahoe-Dark";
        package = gnome-macos-tahoe-theme;
      };
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
  };
}
