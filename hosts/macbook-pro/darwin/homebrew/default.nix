{ config, ... }:
{
  imports = [
    ./fixes

    ./brews.nix
    ./casks.nix
    ./installer.nix
    ./mas.nix
    ./taps.nix
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
