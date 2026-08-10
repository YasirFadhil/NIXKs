{ lib, stdenv, fetchFromGitHub }:
stdenv.mkDerivation rec {
  pname = "gnome-macos-tahoe-theme";
  version = "unstable-2026-08-03";
  src = fetchFromGitHub {
    owner = "kayozxo";
    repo = "GNOME-macOS-Tahoe";
    rev = "78661131d81abebf8732eec638b3d71317d57fd0";
    sha256 = "sha256-aWjag/sbFJ1g6kjiXfzlvknUVGfWtLoBGLlh2DXrT5g=";

  };
  dontBuild = true;
  dontConfigure = true;
  dontPatch = true;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/themes
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
