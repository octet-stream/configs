{
  self,
  inputs,
  lib,
  ...
}:
let
  mkPkgsUnstable =
    system:
    import inputs.nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };

  # Adds nix-darwin host configuration for given `system` and `name`
  mkDarwinSystem =
    system: name:
    let
      pkgsUnstable = mkPkgsUnstable system;
    in
    {
      ${name} = inputs.nix-darwin.lib.darwinSystem {
        specialArgs = { inherit pkgsUnstable; };

        modules = [
          self.modules.darwin.${name}

          {
            nixpkgs = {
              hostPlatform = lib.mkDefault system;
              config.allowUnfree = lib.mkDefault true;
            };
          }
        ];
      };
    };

  # Adds NixOS host configuration for given `system` and `name`
  mkNixosSystem =
    system: name:
    let
      pkgsUnstable = mkPkgsUnstable system;
    in
    {
      ${name} = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit pkgsUnstable; };

        modules = [
          self.modules.nixos.${name}

          {
            nixpkgs = {
              hostPlatform = lib.mkDefault system;
              config.allowUnfree = lib.mkDefault true;
            };
          }
        ];
      };
    };
in
{
  flake.lib = {
    inherit mkDarwinSystem mkNixosSystem;
  };
}
