{ pkgs, lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "gnome-macos-tahoe-theme";
  version = "unstable-2025-01-16";

  src = fetchFromGitHub {
    owner = "kayozxo";
    repo = "GNOME-macOS-Tahoe";
    rev = "main";
    sha256 = "sha256-A0YOqjvWC41TCg2SymLEyXrNX2ArElyezJzh0Q1Hsd0=";
  };

  dontBuild = true;
  dontConfigure = true;
  dontPatch = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/themes

    # Copy all theme variants from the gtk directory
    # The repository contains pre-built themes in the gtk/ folder
    if [ -d gtk ]; then
      for theme in gtk/*/; do
        theme_name=$(basename "$theme")
        cp -r "$theme" "$out/share/themes/$theme_name"
      done
    fi

    runHook postInstall
  '';

  meta = with lib; {
    description = "A macOS Tahoe inspired GTK theme for GNOME desktops";
    homepage = "https://github.com/kayozxo/GNOME-macOS-Tahoe";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
    maintainers = [];
  };
}
