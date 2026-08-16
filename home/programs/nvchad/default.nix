{ 
  inputs, 
  pkgs, 
  ... 
}: 

{
  imports = [
    inputs.nix4nvchad.homeManagerModules.default
  ];

  home.packages = with pkgs; [ 
    # Language servers
    bash-language-server
    typescript-language-server
    typescript
    lua-language-server
    vscode-langservers-extracted
    tailwindcss-language-server
    pyright
    nil
    
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
    hm-activation = true;

    # Explicitly inject these binaries into the Neovim execution environment
    # extraPackages = with pkgs; [
    #   # Language servers
    #   bash-language-server
    #   typescript-language-server
    #   typescript
    #   lua-language-server
    #   vscode-langservers-extracted
    #   tailwindcss-language-server
    #   pyright
    #   nil
    #
    #   # Formatters
    #   prettier
    #   black
    #   stylua
    #
    #   # Utilities
    #   ripgrep
    #   fd
    #   tree-sitter
    # ];
  };

  # Main NvChad UI and Theme configuration
  xdg.configFile."nvim/lua/chadrc.lua".text = ''
    ---@type ChadrcConfig
    local M = {}

    M.base46 = {
      transparency = true,
      theme = "dark_horizon", 
    }

    M.nvdash = {
      load_on_startup = true,
    }

    return M
  '';

  # LSP Configurations for TypeScript, Nix, and your other languages
  xdg.configFile."nvim/lua/configs/lspconfig.lua".text = ''
    local configs = require("nvchad.configs.lspconfig")
    local lspconfig = require("lspconfig")

    local servers = { "html", "cssls", "tailwindcss", "pyright", "bashls", "nil_ls" }

    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
        on_init = configs.on_init,
        on_attach = configs.on_attach,
        capabilities = configs.capabilities,
      }
    end

    lspconfig.ts_ls.setup {
      on_init = configs.on_init,
      on_attach = configs.on_attach,
      capabilities = configs.capabilities,
      filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
      root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
    }
  '';

  # Intercept the plugin loading sequence to hide the deprecation error screen
  xdg.configFile."nvim/lua/plugins/init.lua".text = ''
    vim.deprecate = function() end
    return {
      {
        "neovim/nvim-lspconfig",
        config = function()
          require("configs.lspconfig")
        end,
      },
    }
  '';
}

