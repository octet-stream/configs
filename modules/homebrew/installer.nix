{ inputs, ... }: {
  flake.modules.darwin.homebrew = { config, ... }: {
    imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];

    nix-homebrew = {
      enable = true;

      # As long as my config is for single-user setup this should be fine and it frees me from repeating same thing over and over again, at least here.
      user = config.system.primaryUser;
    };
  };
}
