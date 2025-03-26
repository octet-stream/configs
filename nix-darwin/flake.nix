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
  };

  outputs =
    {
      self,
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
          ./configuration.nix

          home-manager.darwinModules.home-manager

          {
            home-manager = {
              extraSpecialArgs = { inherit self; };
              backupFileExtension = "backup";
              useGlobalPkgs = true;
              useUserPackages = true;
              users.octetstream = import ./home.nix;
            };
          }
        ];

        specialArgs = { inherit self; }; # Expose `self` to darwin nodules
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."macbook-pro".pkgs;
    };
}
