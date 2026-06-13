{
  flake.modules.darwin.macbook-pro = {
    networking.hostName = "macbook-pro";
    system = {
      primaryUser = "octetstream";
      stateVersion = 5;
    };
  };
}
