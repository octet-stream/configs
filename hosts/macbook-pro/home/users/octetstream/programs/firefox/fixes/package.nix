{ pkgs, lib, ... }:
{
  programs.firefox.package = lib.makeOverridable ({ ... }: pkgs.firefox-bin) { }; # https://github.com/nix-community/home-manager/issues/6955#issuecomment-3109421819

  # https://github.com/booxter/home-manager/commit/dd1602e306fec366280f5953c5e1b553e3d9672a
  # Mimic nixpkgs package environment for read-only profiles.ini management
  home.sessionVariables = {
    MOZ_LEGACY_PROFILES = "1";
    MOZ_ALLOW_DOWNGRADE = "1";
  };
}
