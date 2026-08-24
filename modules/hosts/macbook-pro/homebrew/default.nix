{ self, ... }: {
  flake.modules.darwin.macbook-pro = { ... }: {
    imports = [ self.modules.darwin.homebrew ];

    nix-homebrew.enableRosetta = true;
  };
}
