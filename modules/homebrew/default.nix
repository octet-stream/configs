{
  flake.modules.darwin.homebrew = { config, ... }: {
    homebrew = {
      taps = builtins.attrNames config.nix-homebrew.taps;

      enable = true;
      global.autoUpdate = false;

      onActivation = {
        upgrade = true;
        cleanup = "zap";
      };
    };
  };
}
