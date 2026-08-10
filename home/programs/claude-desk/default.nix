{
  pkgs,
  inputs,
  ...
}:

{
  home.packages = with pkgs; [
    inputs.claude-desktop.packages."${stdenv.hostPlatform.system}".default
  ];
}
