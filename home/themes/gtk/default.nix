{ pkgs, ... }:

let
  mactahoe-icon-theme = pkgs.callPackage ../icons/mactahoe.nix {};
  gnome-macos-tahoe-theme = pkgs.callPackage ./gnome-macos-tahoe.nix {
    dart-sass = pkgs.dart-sass;
  };
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
      name = "Liga SFMonoNerdFont Medium";
      size = 11;
    };

    iconTheme = {
      name = "MacTahoe";
      package = mactahoe-icon-theme;
    };

    cursorTheme = {
      name = "MacTahoe-dark";
      package = mactahoe-icon-theme;
      size = 24;
    };

    gtk3 = {
      extraConfig = {
        gtk-toolbar-style = "GTK_TOOLBAR_ICONS";
        gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
        gtk-button-images = 0;
        gtk-menu-images = 0;
        gtk-enable-event-sounds = 1;
        gtk-enable-input-feedback-sounds = 0;
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintslight";
        gtk-xft-rgba = "rgb";
        gtk-application-prefer-dark-theme = 1;
      };
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

  xdg.configFile."gtk-4.0/gtk-dark.css".text = ''
    @import url("${gnome-macos-tahoe-theme}/share/themes/Tahoe-Dark/gtk-4.0/gtk-dark.css");
  '';
}
