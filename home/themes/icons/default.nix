{ pkgs, lib, ... }:

{
  # MacTahoe icon theme package
  mactahoe-icon-theme = pkgs.callPackage ./mactahoe.nix {};
}
