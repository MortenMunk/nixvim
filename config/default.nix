{pkgs, ...}: {
  imports = [
    ./option.nix
    ./diagnostics.nix
    ./performance.nix
    ./keymaps.nix
    ./plugins/default.nix
  ];

  viAlias = true;
  vimAlias = true;

  colorschemes.catppuccin = {
    enable = true;
    settings = {
      flavour = "macchiato";
    };
  };

  extraPackages = with pkgs; [
    ripgrep
  ];

  clipboard = {
    register = "unnamedplus";
    providers.wl-copy.enable = true;
  };
}
