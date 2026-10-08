{pkgs, ...}: let
  faceIdPython = pkgs.python3.withPackages (ps: [
    ps.numpy
    (ps.opencv4.override {enableContrib = true;})
  ]);
in {
  # path stabil ke interpreter khusus Face ID (tidak masuk PATH)
  home.file.".local/share/faceid-python".source = faceIdPython;
}
