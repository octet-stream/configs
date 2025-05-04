# Overrides Firefox package, because default package doesn't support macOS (yet).
#
# Note that [`firefox-bin`](https://github.com/bandithedoge/nixpkgs-firefox-darwin) is not universal,
# so the default version is set for Linux

{ pkgs, lib, ... }:
lib.mkIf pkgs.stdenv.isDarwin {
  programs.firefox.package = pkgs.firefox-bin;
}
