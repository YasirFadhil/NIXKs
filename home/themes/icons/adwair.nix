{
  pkgs,
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "adwair";
  version = "2026-10-18";

  src = fetchFromGitHub {
    owner = "kusaida";
    repo = "Adwair";
    rev = "a54d5173cf1f93ab7d09da98a164cf36721dc070";
    hash = "sha256-2Tj4PmecvVA3T5GmKBkYdkjnspIue/u0LiYPaNMXk10=";
  };

  nativeBuildInputs = with pkgs; [
    bash
    coreutils
    findutils
    gawk
    gnused
    gtk3
  ];

  dontBuild = true;
  dontDropIconThemeCache = true;
  dontCheckForBrokenSymlinks = true;

  installPhase = ''
    runHook preInstall

    bash ./install.sh \
      --name Adwair \
      --path "$out/share/icons"

    runHook postInstall
  '';

  meta = with lib; {
    description = "WhiteSur-inspired icon theme with Adwaita styling";
    homepage = "https://github.com/kusaida/Adwair";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
    maintainers = [];
  };
}
