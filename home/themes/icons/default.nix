{pkgs, ...}: {
  # MacTahoe icon theme package
  mactahoe-icon-theme = pkgs.callPackage ./mactahoe.nix {};

  # Adwair icon theme package
  adwair = pkgs.callPackage ./adwair.nix {};
}
