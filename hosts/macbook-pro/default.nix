{ inputs, ... }:
{
  imports = with inputs; [
    # mac-app-util.darwinModules.default # Applies a fix for the apps linked by nix-darwin
    nix-homebrew.darwinModules.nix-homebrew # Adds homebrew installation manager
    home-manager.darwinModules.home-manager # Adds Home Manager

    ./darwin
    ./home
  ];
}
