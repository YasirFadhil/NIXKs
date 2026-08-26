{ lib, stdenv, fetchFromGitHub, dart-sass }:
stdenv.mkDerivation rec {
  pname = "gnome-macos-tahoe-theme";
  version = "unstable-2026-08-03";
  src = fetchFromGitHub {
    owner = "kayozxo";
    repo = "GNOME-macOS-Tahoe";
    rev = "78661131d81abebf8732eec638b3d71317d57fd0";
    sha256 = "sha256-aWjag/sbFJ1g6kjiXfzlvknUVGfWtLoBGLlh2DXrT5g=";
  };
  nativeBuildInputs = [ dart-sass ];
  dontConfigure = true;
  buildPhase = ''
    runHook preBuild
    mkdir -p gtk/Tahoe-Dark/gtk-4.0 gtk/Tahoe-Light/gtk-4.0
    sass src/targets/Tahoe-Dark-gtk4.scss gtk/Tahoe-Dark/gtk-4.0/gtk.css
    cp gtk/Tahoe-Dark/gtk-4.0/gtk.css gtk/Tahoe-Dark/gtk-4.0/gtk-dark.css
    sass src/targets/Tahoe-Light-gtk4.scss gtk/Tahoe-Light/gtk-4.0/gtk.css
    cp gtk/Tahoe-Light/gtk-4.0/gtk.css gtk/Tahoe-Light/gtk-4.0/gtk-dark.css
    if [ -d gtk/Tahoe-Dark/gtk-3.0/assets ]; then
      cp -r gtk/Tahoe-Dark/gtk-3.0/assets gtk/Tahoe-Dark/gtk-4.0/assets
    fi
    if [ -d gtk/Tahoe-Light/gtk-3.0/assets ]; then
      cp -r gtk/Tahoe-Light/gtk-3.0/assets gtk/Tahoe-Light/gtk-4.0/assets
    fi
    runHook postBuild
  '';
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
