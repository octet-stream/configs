{ inputs, ... }: {
  flake.modules.darwin.homebrew =
    { ... }:
    {
      nix-homebrew = {
        mutableTaps = false;

        taps = with inputs; {
          "homebrew/homebrew-core" = homebrew-core;
          "homebrew/homebrew-cask" = homebrew-cask;
          "infisical/homebrew-get-cli" = infisical-cli;
        };
      };
    };
}
