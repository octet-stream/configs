{ self, ... }:
{
  nix-homebrew = {
    mutableTaps = false;

    taps = with self.inputs; {
      "homebrew/homebrew-core" = homebrew-core;
      "homebrew/homebrew-cask" = homebrew-cask;
    };
  };
}
