{ inputs, lib, ... }: {
  flake.lib = {
    # Adds nix-darwin host configuration for given `system` and `name`
    mkDarwinSystem = system: name: {
      ${name} = inputs.nix-darwin.lib.darwinSystem {
        modules = [
          inputs.self.modules.darwin.${name}

          {
            nixpkgs = {
              hostPlatform = lib.mkDefault system;
              config.allowUnfree = true;
            };
          }
        ];
      };
    };
  };
}
