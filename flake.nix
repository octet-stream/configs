{
  description = "My Nix Darwin flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    systems.url = "github:nix-systems/default";
  };

  outputs =
    {
      self,
      nixpkgs,
      systems,
      nix-darwin,
      home-manager,
      ...
    }:
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#macbook-pro
      # Or build & switch using:
      # $ darwin-rebuild switch --flake .#macbook-pro
      darwinConfigurations."macbook-pro" = nix-darwin.lib.darwinSystem {
        modules = [
          ./darwin

          home-manager.darwinModules.home-manager

          {
            home-manager = {
              extraSpecialArgs = { inherit self; };
              backupFileExtension = "backup";
              useGlobalPkgs = true;
              useUserPackages = true;
              users.octetstream = import ./nix-darwin/home.nix; # TODO: Move home-manager configuration to different directory
            };
          }
        ];

        specialArgs = { inherit self; }; # Expose `self` to darwin nodules
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."macbook-pro".pkgs;

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

                # Corepack is broken prior v0.31.x, so use Node.js v23 for now, which includes it
                nodejs_23
                corepack_23
              ];
            };
        }
      );
    };
}
