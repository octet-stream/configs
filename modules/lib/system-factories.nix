{
  self,
  inputs,
  lib,
  ...
}:
let
  # Adds nix-darwin host configuration for given `system` and `name`
  mkDarwinSystem = system: name: {
    ${name} = inputs.nix-darwin.lib.darwinSystem {
      modules = [
        self.modules.darwin.${name}

        {
          nixpkgs = {
            hostPlatform = lib.mkDefault system;
            config.allowUnfree = true;
          };
        }
      ];
    };
  };
in
{
  flake.lib = { inherit mkDarwinSystem; };
}
