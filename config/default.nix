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

  colorschemes.gruvbox.enable = true;

  extraPackages = with pkgs; [
    ripgrep
  ];

  clipboard = {
    register = "unnamedplus";
    providers.wl-copy.enable = true;
  };
}
