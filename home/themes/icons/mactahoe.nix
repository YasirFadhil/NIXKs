{ pkgs, lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "mactahoe-icon-theme";
  version = "unstable-2025-01-16";

  src = fetchFromGitHub {
    owner = "vinceliuice";
    repo = "MacTahoe-icon-theme";
    rev = "main";
    sha256 = "1wzqnk6k3q68n07xs7lgfj5zwl62x45crxzp2vka8xbaarz4q1mn";
  };

  nativeBuildInputs = [ pkgs.gtk3 ];

  dontDropIconThemeCache = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons

    # Install all color variants
    # Available: default(blue)/purple/pink/red/orange/yellow/green/grey

    # Install default (blue) theme
    bash install.sh -d $out/share/icons -n MacTahoe -t default

    # Install other color variants if needed
    # bash install.sh -d $out/share/icons -n MacTahoe -t purple
    # bash install.sh -d $out/share/icons -n MacTahoe -t pink
    # bash install.sh -d $out/share/icons -n MacTahoe -t red
    # bash install.sh -d $out/share/icons -n MacTahoe -t orange
    # bash install.sh -d $out/share/icons -n MacTahoe -t yellow
    # bash install.sh -d $out/share/icons -n MacTahoe -t green
    # bash install.sh -d $out/share/icons -n MacTahoe -t grey

    # For 4K displays, use bold version:
    # bash install.sh -d $out/share/icons -n MacTahoe -t default -b

    # Update icon cache
    for theme in $out/share/icons/*; do
      if [ -f "$theme/index.theme" ]; then
        gtk-update-icon-cache -f -t $theme
      fi
    done

    runHook postInstall
  '';

  meta = with lib; {
    description = "MacOS Tahoe icon theme for Linux desktops";
    homepage = "https://github.com/vinceliuice/MacTahoe-icon-theme";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
    maintainers = [];
  };
}
