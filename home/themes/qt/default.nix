{ pkgs, lib, config, ... }:

{
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };

  home.packages = with pkgs; [
    # Qt theme packages
    adwaita-qt
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
    kdePackages.breeze
    kdePackages.breeze-icons
    # macOS-like kvantum themes would be good here, e.g.
    # whitesur-kde
  ];

  # Ensure Qt uses the same cursor theme and icons as GTK
  # Also set Wayland-specific Qt variables for better integration
  home.sessionVariables = {
    # QT_QPA_PLATFORM_THEME is handled by qt.platformTheme.name = "qtct"
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    
    XCURSOR_THEME = "MacTahoe-dark";
    XCURSOR_SIZE = "20";
  };
}
