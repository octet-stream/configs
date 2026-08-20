{ inputs, self, ... }: {
  flake.modules.darwin.macbook-pro = { ... }: {
    imports = [
      inputs.home-manager.darwinModules.home-manager
      self.modules.darwin.homebrew
    ];

    nix-homebrew.enableRosetta = true;

    networking.hostName = "macbook-pro";
    system = {
      primaryUser = "octetstream";
      stateVersion = 5;
    };
  };
}
