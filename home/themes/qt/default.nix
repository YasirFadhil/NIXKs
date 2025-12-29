{ pkgs, lib, config, ... }:

{
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  home.packages = with pkgs; [
    # Qt theme packages
    adwaita-qt
    libsForQt5.qtstyleplugin-kvantum
    qt6Packages.qt6gtk2
    kdePackages.breeze
    kdePackages.breeze-icons
  ];

  # Ensure Qt uses the same cursor theme and icons as GTK
  home.sessionVariables = {
    QT_QPA_PLATFORM_THEME = "gtk3";
    QT_STYLE_OVERRIDE = "Adwaita-Dark";
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "20";
  };
}
