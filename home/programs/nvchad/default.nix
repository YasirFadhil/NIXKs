{ inputs, config, pkgs, ... }: {
  imports = [
    inputs.nix4nvchad.homeManagerModule
  ];

  programs.nvchad = {
    enable = true;

    # LSP servers, formatters, and other tools
    extraPackages = with pkgs; [
      # Language servers
      nodePackages.bash-language-server
      nodePackages.typescript-language-server
      lua-language-server
      pyright

      # Formatters
      nodePackages.prettier
      black
      stylua

      # Utilities
      ripgrep
      fd
      tree-sitter
    ];

    # Home-manager manages the NvChad config in ~/.config/nvim
    hm-activation = true;

    # Create backups when config changes
    backup = true;
  };
}
