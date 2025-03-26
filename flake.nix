{
  description = "Development environment for dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.11";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    {
      nixpkgs,
      systems,
      ...
    }:
    {
      devShells = nixpkgs.lib.genAttrs (import systems) (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default =
            with pkgs;
            mkShell {
              nativeBuildInputs = [
                nixd
                nixfmt-rfc-style
                nodejs_23
                corepack_23
              ];
            };
        }
      );
    };
}
