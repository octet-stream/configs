{
  description = "My Nix Darwin flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    easy-hosts.url = "github:tgirlcloud/easy-hosts";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Homebrew package
    homebrew = {
      url = "github:Homebrew/brew/4.5.7"; # I'll have to bump the version by myself, because auto-updates are disabled
      flake = false;
    };

    # Manages homebrew installation
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

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
      url = "github:nix-community/nix4vscode/a39361da946a2710136be7fcda249908ba06dcb1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zed-extensions = {
      url = "github:DuskSystems/nix-zed-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      flake-parts,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "aarch64-darwin" ];
      imports = [ ./hosts ];

      perSystem =
        { pkgs, ... }:
        {
          devShells.default = import ./shell.nix { inherit pkgs; };
        };
    };
}
