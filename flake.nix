{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixvim,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
      perSystem = {system, ...}: let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            nix.nixPath = ["nixpkgs=${nixpkgs}"];
          };
        };
        nixvimModule = {
          inherit pkgs;
          module = import ./config;
          extraSpecialArgs = {
            inherit self;
            inherit system;
          };
        };
      in {
        checks = {
          # Run `nix flake check .` to verify that your config is not broken
          default = nixvim.lib.${system}.check.mkTestDerivationFromNixvimModule nixvimModule;
        };

        packages = {
          # Lets you run `nix run .` to start nixvim
          default = nixvim.legacyPackages.${system}.makeNixvimWithModule nixvimModule;
        };
      };
    };
}
