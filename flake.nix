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

    # TODO: Remove this (and the overlay) once 4.x is released (and from home-manager)
    nh = {
      url = "github:nix-community/nh";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Manages homebrew installation
    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Homebrew core repository
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    # Homebrew casks repository
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    # List of default supported systems
    systems.url = "github:nix-systems/default";

    # Fix for apps symlinks managed by Nix on macOS
    mac-app-util = {
      url = "github:hraban/mac-app-util";

      # This flake pins specific revision of the nixpkgs, but current stable channel seem to have requested dependencies, to I think it safe to override this one
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # VSCode extensions
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Also VSCode extensions, with more individual approach
    # I'll move to this one at some point
    nix4vscode = {
      url = "github:nix-community/nix4vscode/45819da9810ade1c2e6a7c82dcec5a28d2830ebf"; # ! latest version is broken, so I pin this commit for some time
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
    {
      users = {
        octetstream = import ./users/octetstream.nix;
      };

      darwinConfigurations."macbook-pro" = nix-darwin.lib.darwinSystem {
        modules = [
          mac-app-util.darwinModules.default # Enables fix for darwin managed apps
          nix-homebrew.darwinModules.nix-homebrew
          home-manager.darwinModules.home-manager

          ./darwin
          ./home-manager
        ];

        # Expose additional args to darwin modules
        specialArgs = { inherit self; };
      };

      devShells = nixpkgs.lib.genAttrs (import systems) (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default = import ./shell.nix { inherit pkgs; };
        }
      );
    };
}
