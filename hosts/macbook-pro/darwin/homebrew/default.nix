{ config, ... }:
{
  imports = [
    ./brews.nix
    ./casks.nix
    ./installer.nix
    ./mas.nix
  ];

  homebrew = {
    enable = true;
    global.autoUpdate = false;

    onActivation = {
      upgrade = true;
      cleanup = "zap";
    };

    taps = builtins.attrNames config.nix-homebrew.taps;
  };
}
