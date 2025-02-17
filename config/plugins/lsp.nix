{
  pkgs,
  self,
  ...
}: {
  plugins.lsp = {
    enable = true;

    keymaps = {
      silent = true;

      lspBuf = {
        "<leader>a" = {
          action = "code_action";
          desc = "Code action";
        };
        gd = {
          action = "definition";
          desc = "Goto definition";
        };
        gD = {
          action = "declaration";
          desc = "Goto declaration";
        };
        gt = {
          action = "type_definition";
          desc = "Goto type definition";
        };
        "<leader>r" = {
          action = "rename";
          desc = "Rename";
        };
      };

      extra = [
        {
          mode = "n";
          key = "gr";
          action = ":Telescope lsp_references<cr>";
          options = {
            desc = "Goto references";
            silent = true;
            noremap = true;
          };
        }
        {
          mode = "n";
          key = "gi";
          action = ":Telescope lsp_implementations<cr>";
          options = {
            desc = "Goto implementations";
            silent = true;
            noremap = true;
          };
        }
        {
          mode = "n";
          key = "<leader>s";
          action = ":Telescope lsp_document_symbols<cr>";
          options = {
            desc = "Document symbols";
            silent = true;
            noremap = true;
          };
        }
        {
          mode = "n";
          key = "<leader>S";
          action = ":Telescope lsp_workspace_symbols<cr>";
          options = {
            desc = "Workspace symbols";
            silent = true;
            noremap = true;
          };
        }
      ];
    };

    servers = {
      # NIX
      nixd = {
        enable = true;
        filetypes = ["nix"];
        settings = let
          getFlake = ''(builtins.getFlake "${self}")'';
          # Change below to your home-manager username
          username = "morten";
        in {
          formatting.command = ["alejandra"];
          nixpkgs.expr = "import ${getFlake}.inputs.nixpkgs { }";
          options = {
            nixos.expr = "${getFlake}.nixosConfigurations.nixos.options";
            nixvim.expr = "${getFlake}.packages.${pkgs.system}.nvim.options";
            home-manager.expr = ''${getFlake}.homeConfigurations.${username}.options'';
            flake-parts.expr = ''let flake = ${getFlake}; in flake.debug.options // flake.currentSystem.options'';
          };
        };
      };
      # HASKELL
      hls = {
        enable = true;
        installGhc = false;
      };
      # TYPESCRIPT/JAVASCRIPT
      ts_ls.enable = true;

      # C & C++
      clangd.enable = true;

      # Coq
      coq_lsp.enable = true;

      # GO
      gopls.enable = true;

      # DART
      dartls.enable = true;
    };
  };
}
