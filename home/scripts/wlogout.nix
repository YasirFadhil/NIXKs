{ pkgs, ... }:

pkgs.writeShellScriptBin "wlogout" ''
  #!${pkgs.nushell}/bin/nu

  # Launch wlogout
  /etc/profiles/per-user/yasirfadhil/bin/wlogout
''
