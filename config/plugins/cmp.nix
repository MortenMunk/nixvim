{
  plugins = {
    cmp = {
      enable = true;
      settings = {
        autoEnableSources = true;
        preselect = "cmp.PreselectMode.None";

        enabled.__raw = ''
          function()
            local in_prompt = vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt'
            if in_prompt then  -- this will disable cmp in the Telescope window (taken from the default config)
              return false
            end
            local context = require("cmp.config.context")
            return not(context.in_treesitter_capture("comment") == true or context.in_syntax_group("Comment"))
          end
        '';

        performance = {
          debounce = 60;
          fetchingTimeout = 200;
          maxViewEntries = 10;
        };

        formatting = {
          fields = [
            "abbr"
            "kind"
            "menu"
          ];

          format.__raw = ''
            function(entry, vim_item)
              local label = vim_item.abbr
              local truncated_label = vim.fn.strcharpart(label, 0, 25)
              if truncated_label ~= label then
                vim_item.abbr = truncated_label .. "…"
              elseif string.len(label) < 25 then
                local padding = string.rep(" ", 25 - string.len(label))
                vim_item.abbr = label .. padding
              end

              local ci = entry.completion_item
              if ci.labelDetails and ci.labelDetails.detail then
                vim_item.menu = ci.labelDetails.detail:match("^%s*(.-)%s*$")
              end

              return vim_item
            end
          '';
        };

        sources = [
          {
            name = "nvim_lsp";
            entry_filter.__raw = ''
              function(entry, ctx)
                return require("cmp.types").lsp.CompletionItemKind[entry:get_kind()]  ~= "Text"
              end
            '';
            priority = 3;
          }
          {
            name = "buffer";
            entry_filter.__raw = ''
              function(entry, ctx)
                return require("cmp.types").lsp.CompletionItemKind[entry:get_kind()]  ~= "Text"
              end
            '';
            priority = 2;
          }
          {
            name = "path"; # file system paths
            keywordLength = 3;
            priority = 1;
          }
        ];

        sorting = {
          priority_weight = 1;
          comparators = [
            "require('cmp.config.compare').offset"
            "require('cmp.config.compare').exact"
            "require('cmp.config.compare').score"
            "require('cmp.config.compare').recently_used"
            "require('cmp.config.compare').locality"
            "require('cmp.config.compare').kind"
            "require('cmp.config.compare').sort_text"
            "require('cmp.config.compare').length"
            "require('cmp.config.compare').order"
          ];
        };

        window = {
          completion = {
            scrollbar = true;
          };
        };

        mapping = {
          "<C-j>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 'n', 'c'})";
          "<C-k>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 'n', 'c'})";
          "<C-c>" = "cmp.mapping(cmp.mapping.abort(), {'i', 'n', 'c'})";
          "<C-b>" = "cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'n'})";
          "<C-f>" = "cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'n'})";
          "<CR>" = "cmp.mapping(cmp.mapping.confirm({ select = false }), {'i', 'n'})";
        };
      };
    };
    cmp-nvim-lsp.enable = true;
    cmp-buffer.enable = true;
    cmp-path.enable = true;
    cmp-cmdline.enable = true;
    friendly-snippets.enable = true;
  };
  extraConfigLua = ''
    local cmp = require'cmp'

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({'/', "?" }, {
      sources = {
        { name = 'buffer' }
      }
    })

    -- Use cmdline source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
      sources = cmp.config.sources({
        { name = 'cmdline' }
      })
    })
  '';
}
