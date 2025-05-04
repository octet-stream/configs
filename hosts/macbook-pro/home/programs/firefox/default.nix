{ pkgs, lib, ... }:
{
  imports = [
    ./extensions.nix
    ./settings.nix
  ];

  programs.firefox = lib.mkMerge [
    {
      enable = true;
    }

    # Override the package, because default package doesn't support macOS (yet).
    #
    # Note that [`firefox-bin`](https://github.com/bandithedoge/nixpkgs-firefox-darwin) is not universal,
    # so the default version is set for Linux
    (lib.mkIf pkgs.stdenv.isDarwin {
      package = pkgs.firefox-bin;
    })
  ];

  # ! To workaround these issues:
  # ! https://github.com/bandithedoge/nixpkgs-firefox-darwin/issues/14
  # ! https://github.com/nix-community/home-manager/issues/3323;
  # !
  # ! Disabled because it doesn't work :D
  # ! But I'm gonna keep these comments for easy reference
  # home.sessionVariables.MOZ_LEGACY_PROFILES = "1";
}
