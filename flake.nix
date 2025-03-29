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

    # TODO: Remove once 4.x is released (and from home-manager)
    nh.url = "github:viperML/nh";

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

    # Fix for apps symlinks managed by Nix on macOS
    mac-app-util.url = "github:hraban/mac-app-util";

    # VSCode extensions
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix4vscode = {
      url = "github:nix-community/nix4vscode";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      systems,
      nix-darwin,
      nix-homebrew,
      mac-app-util,
      home-manager,
      ...
    }:
    let
      user = import ./users/octetstream.nix;
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#macbook-pro
      # Or build & switch using:
      # $ darwin-rebuild switch --flake .#macbook-pro
      darwinConfigurations."macbook-pro" = nix-darwin.lib.darwinSystem {
        modules = [
          ./darwin

          mac-app-util.darwinModules.default
          nix-homebrew.darwinModules.nix-homebrew
          home-manager.darwinModules.home-manager

          # TODO: Move this to a module
          {
            home-manager = {
              extraSpecialArgs = { inherit self; };
              backupFileExtension = "backup";
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${user.username} = import ./home-manager/home.nix;
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
