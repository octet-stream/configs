{ inputs, ... }: {
  flake.modules.darwin.homebrew = { ... }: {
    imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];

    nix-homebrew = {
      enable = true;
      autoMigrate = true;
      enableRosetta = true;
      user = "octetstream";
    };
  };
}
