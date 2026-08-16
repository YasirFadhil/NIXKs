{ pkgs, inputs, ... }:

let
  apple-fonts-pkg = inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system};
in

{
  home.packages = with pkgs; [
    # Apple Fonts
    apple-fonts-pkg.sf-pro
    apple-fonts-pkg.sf-mono
    sf-mono-liga-bin

    # Core fonts
    inter               # Similar to SF Pro
    jetbrains-mono      # Great monospace font
    noto-fonts          # Comprehensive font family
    noto-fonts-color-emoji # Emoji support
    noto-fonts-cjk-sans # CJK support
    ubuntu-classic      # Clean, modern font

    # Icon fonts
    font-awesome        # Icon font

    # Nerd Fonts
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only

    # System fonts
    corefonts           # Microsoft core fonts
  ];

  fonts.fontconfig.enable = true;
}
