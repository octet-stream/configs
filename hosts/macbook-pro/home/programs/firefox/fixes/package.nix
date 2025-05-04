{ pkgs, lib, ... }:
lib.mkIf pkgs.stdenv.isDarwin {
  programs.firefox.package = pkgs.firefox-bin;
}
