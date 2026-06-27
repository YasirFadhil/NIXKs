{ inputs, config, pkgs, ... }: {
  imports = [
    inputs.nix4nvchad.homeManagerModule
  ];

  home.packages = with pkgs; [
    # Language servers
    bash-language-server
    typescript-language-server
    lua-language-server
    vscode-langservers-extracted
    pyright
    
    # Formatters
    prettier
    black
    stylua

    # Utilities
    ripgrep
    fd
    tree-sitter
  ];

  programs.nvchad = {
    enable = true;

    # LSP servers, formatters, and other tools
    extraPackages = with pkgs; [
      # Language servers
      # bash-language-server
      # typescript-language-server
      # lua-language-server
      # vscode-langservers-extracted
      # pyright
      #
      #
      # # Formatters
      # prettier
      # black
      # stylua
      #
      # # Utilities
      # ripgrep
      # fd
      # tree-sitter
    ];

    # Home-manager manages the NvChad config in ~/.config/nvim
    hm-activation = true;

    # Create backups when config changes
    # backup = true;
  };

  xdg.configFile."nvim/lua/chadrc.lua".text = ''
    ---@type ChadrcConfig
    local M = {}

    M.base46 = {
      transparency = true,
      
      -- Optional: You can also hardcode your favorite theme here!
      theme = "dark_horizon", 
    }

    M.nvdash = {
      load_on_startup = true,
    }

    return M
  '';
}
