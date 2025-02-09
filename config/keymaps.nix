{...}: let
  normal = "n";
in {
  globals.mapleader = " ";

  keymaps = [
    # nvim-tree
    {
      mode = normal;
      key = "<leader>F";
      action = ":NvimTreeOpen<cr>";
      options = {
        desc = "Open file tree";
        silent = true;
        noremap = true;
      };
    }

    # telescope
    {
      mode = normal;
      key = "<leader>ff";
      action = ":Telescope find_files<cr>";
      options = {
        desc = "Find project files";
        silent = true;
        noremap = true;
      };
    }
    {
      mode = normal;
      key = "<leader>fg";
      action = ":Telescope live_grep<cr>";
      options = {
        desc = "Workspace search";
        silent = true;
        noremap = true;
      };
    }
    {
      mode = normal;
      key = "<leader>d";
      action = ":Telescope diagnostics bufnr=0<cr>";
      options = {
        desc = "Document diagnostics";
        silent = true;
        noremap = true;
      };
    }
    {
      mode = normal;
      key = "<leader>b";
      action = ":Telescope buffers<cr>";
      options = {
        desc = "Open buffers";
        silent = true;
        noremap = true;
      };
    }
    {
      mode = normal;
      key = "<leader>D";
      action = ":Telescope diagnostics<cr>";
      options = {
        desc = "Workspace diagnostics (depends on LSP)";
        silent = true;
        noremap = true;
      };
    }

    # diagnostics
    {
      mode = normal;
      key = "<leader>e";
      action = ":lua vim.diagnostic.open_float()<cr>";
      options = {
        desc = "Open diagnostic under cursor";
        silent = true;
        noremap = true;
      };
    }
  ];
}
