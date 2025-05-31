# This module overrides Ghostty package for macOS, because nixpkgs have no official package for this platform

{
  config,
  pkgs,
  lib,
  ...
}:
lib.mkIf (config.programs.ghostty.enable && pkgs.stdenv.isDarwin) {
  programs.ghostty.package = pkgs.nur.repos.DimitarNestorov.ghostty;
}
