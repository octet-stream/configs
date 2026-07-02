{ self, ... }:
{
  nix-homebrew = {
    mutableTaps = false;

    taps = with self.inputs; {
      "homebrew/homebrew-core" = homebrew-core;
      "homebrew/homebrew-cask" = homebrew-cask;
      "infisical/homebrew-get-cli" = infisical-cli;
    };

    trust.taps = [ "infisical/homebrew-get-cli" ];
  };
}
