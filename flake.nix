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

    # Manages homebrew installation
    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    systems.url = "github:nix-systems/default";
  };

  outputs =
    {
      self,
      nixpkgs,
      systems,
      nix-darwin,
      nix-homebrew,
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

          nix-homebrew.darwinModules.nix-homebrew
          home-manager.darwinModules.home-manager

          {
            home-manager = {
              extraSpecialArgs = { inherit self; };
              backupFileExtension = "backup";
              useGlobalPkgs = true;
              useUserPackages = true;
              users.octetstream = import ./home-manager/home.nix;
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
                bash-language-server

                # Corepack is broken prior v0.31.x, so use Node.js v23 for now, which includes it
                nodejs_23
                corepack_23
              ];
            };
        }
      );
    };
}
