{ inputs, ... }:
{
  imports = with inputs; [
    nix-homebrew.darwinModules.nix-homebrew # Adds homebrew installation manager
    home-manager.darwinModules.home-manager # Adds Home Manager

    ./darwin
    ./home
  ];
}
