{ inputs, self, ... }: {
  flake.modules.darwin.macbook-pro = { ... }: {
    imports = [
      inputs.home-manager.darwinModules.home-manager
      self.modules.darwin.homebrew
      self.modules.darwin.zed-editor
    ];

    nix-homebrew.enableRosetta = true;

    home-manager = {
      backupFileExtension = "backup";
      useGlobalPkgs = true;
      useUserPackages = true;
    };

    networking.hostName = "macbook-pro";
    system = {
      primaryUser = "octetstream";
      stateVersion = 5;
    };
  };
}
