# Overrides Firefox package to use nixos-unstable, because current stable release has no support for aarch64-darwin
# TODO: Remove this fix after I switch to nixos-25.05

{
  pkgs,
  pkgsUnstable,
  lib,
  ...
}:
lib.mkIf pkgs.stdenv.isDarwin {
  programs.firefox.package = pkgsUnstable.firefox;
}
