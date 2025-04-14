{ inputs, ... }:
{
  imports = with inputs; [
    mac-app-util.darwinModules.default # Enables fix for darwin managed apps
    nix-homebrew.darwinModules.nix-homebrew
    home-manager.darwinModules.home-manager

    ./darwin
    ./home
  ];
}
