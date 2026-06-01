# Spicetify is a spotify client customizer
{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.text;  # Changed to lowercase 'default'
    # theme = {
    #   name = "text";

    #   src = pkgs.fetchFromGitHub {
    #     owner = "spicetify";
    #     repo = "spicetify-themes";
    #     rev = "master";
    #     hash = "sha256-jEBkyzCjcN6eUZ/RLmxRIPlrL1PEvKGOr/9auQOsqPg=";
    #   };

    #   injectCss = true;
    #   injectThemeJs = true;
    #   replaceColors = true;
    #   homeConfig = true;
    #   overwriteAssets = false;
    # };

    enabledExtensions = with spicePkgs.extensions; [
      playlistIcons
      lastfm
      historyShortcut
      hidePodcasts
      adblock
      fullAppDisplay
      shuffle
    ];
  };
}
