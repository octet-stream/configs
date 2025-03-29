# Homebrew installation managed by Nix

{ self, ... }:
{
  nix-homebrew = {
    enable = true;
    mutableTaps = false;
    autoMigrate = true;
    enableRosetta = true;
    user = "octetstream";

    taps = {
      "homebrew/homebrew-core" = self.inputs.homebrew-core;
      "homebrew/homebrew-cask" = self.inputs.homebrew-cask;
    };
  };
}
