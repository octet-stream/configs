{ self, ... }: {
  flake.modules.darwin.macbook-pro = { ... }: {
    imports = [ self.modules.darwin.homebrew ];

    networking.hostName = "macbook-pro";
    system = {
      primaryUser = "octetstream";
      stateVersion = 5;
    };
  };
}
