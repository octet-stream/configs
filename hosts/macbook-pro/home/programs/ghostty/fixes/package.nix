# This module overrides Ghostty package for macOS, because nixpkgs have no official package for this platform

{ pkgs, lib, ... }:
lib.mkIf pkgs.stdenv.isDarwin {
  programs.ghostty.package = pkgs.nur.repos.DimitarNestorov.ghostty;
}
