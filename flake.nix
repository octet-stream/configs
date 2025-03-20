{
  description = "Development environment for dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.11";
    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      utils,
      ...
    }:
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShell =
          with pkgs;
          mkShell {
            nativeBuildInputs = [
              git
              nixd
              nixfmt-rfc-style
              nodejs_23
              corepack_23
            ];
          };
      }
    );
}
