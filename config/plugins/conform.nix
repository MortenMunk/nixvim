{pkgs, ...}: {
  extraPackages = with pkgs; [
    ormolu
    alejandra
    rustfmt
    taplo
    biome
    prettierd
    ruff
  ];

  plugins.conform-nvim = {
    enable = true;

    settings = {
      notify_on_error = true;
      format_on_save = {
        lspFallback = true;
        timeoutMs = 500;
      };

      formatters_by_ft = {
        html = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        css = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        javascript = ["biome"];
        javascriptreact = ["biome"];
        typescript = ["biome"];
        typescriptreact = ["biome"];
        python = ["ruff_format"];
        nix = ["alejandra"];
        rust = ["rustfmt"];
        toml = ["taplo"];
        haskell = ["ormolu"];
        cpp = ["clang-format"];
        c = ["clang-format"];
        go = ["gofmt"];
        dart = ["dart_format"];
      };
    };
  };
}
