# This module overrides Ghostty package for macOS, because nixpkgs have no official package for this platform

{
  config,
  pkgs,
  pkgsUnstable,
  lib,
  ...
}:
lib.mkIf (config.programs.ghostty.enable && pkgs.stdenv.isDarwin) {
  programs.ghostty.package = pkgsUnstable.ghostty-bin;
}
