{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # TODO: Change the lldb package from merged commit to unstable branch after freeze
    # Use nixpkgs commit with fixed lldb fix (Currently in breaking change freeze)
    nixpkgs-lldb.url =
      "github:nixos/nixpkgs?rev=8c429107e982d4debdb67f2c3e3402a23a308f05";
    nixpkgs-cmp-dict.url =
      "github:nixos/nixpkgs?rev=e5d1c87f5813afde2dda384ac807c57a105721cc";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = { nixvim, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems =
        [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];

      perSystem = { pkgs, system, ... }:
        let
          nixvimLib = nixvim.lib.${system};
          pkgs-cmp-dict = import inputs.nixpkgs-cmp-dict { inherit system; };
          pkgs-lldb = import inputs.nixpkgs-lldb { inherit system; };
          nixvimModule = {
            inherit pkgs;
            module = import ./config.nix; # import the module directly
            # You can use `extraSpecialArgs` to pass additional arguments to your module files
            extraSpecialArgs = {
              inherit pkgs-cmp-dict;
              inherit pkgs-lldb;
            };
          };
          nvim =
            nixvim.legacyPackages.${system}.makeNixvimWithModule nixvimModule;
        in
        {
          checks = {
            # Run `nix flake check .` to verify that your config is not broken
            nvim =
              nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
          };

          packages = {
            # Lets you run `nix run .` to start nixvim
            nvim = nvim;
          };
        };
    };
}
