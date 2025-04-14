{ pkgs, ... }:
{
  imports = [
    ./extensions.nix
    ./settings.nix
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-bin; # Override the package, because default package set doesn't support macOS
  };
}
