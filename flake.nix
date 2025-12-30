{
  description = "My Nix Darwin flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    easy-hosts.url = "github:tgirlcloud/easy-hosts";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Homebrew package
    homebrew = {
      url = "github:Homebrew/brew/5.0.8"; # I'll have to bump the version by myself, because auto-updates are disabled
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

    infisical-cli = {
      url = "github:Infisical/homebrew-get-cli";
      flake = false;
    };

    # List of default supported systems
    systems.url = "github:nix-systems/default";

    # Fix for apps symlinks managed by Nix on macOS
    mac-app-util = {
      url = "github:hraban/mac-app-util";

      # This flake pins specific revision of the nixpkgs, but current stable channel seem to have requested dependencies, to I think it safe to override this one
      inputs = {
        nixpkgs.follows = "nixpkgs";

        # ! Overriden as termporarily workaround as suggested here: https://github.com/hraban/mac-app-util/issues/39#issuecomment-3503946041
        cl-nix-lite.url = "github:r4v3n6101/cl-nix-lite/6deefd29913ad23b73db8f1ade0a397e1518619f";
      };
    };

    # VSCode extensions
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";

      # ! Switch back to stable channel once this backported: https://github.com/NixOS/nixpkgs/pull/464215
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Also VSCode extensions, with more individual approach
    # I'll move to this one at some point
    nix4vscode = {
      url = "github:nix-community/nix4vscode";

      # ! Switch back to stable channel once this backported: https://github.com/NixOS/nixpkgs/pull/464215
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    zed-extensions = {
      url = "github:DuskSystems/nix-zed-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {
      # ! Switch to 25.11 when this is resolved: https://github.com/catppuccin/nix/issues/782
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-firefox-darwin = {
      url = "github:bandithedoge/nixpkgs-firefox-darwin";
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
