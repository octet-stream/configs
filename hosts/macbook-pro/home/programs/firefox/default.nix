{ pkgs, ... }:
{
  imports = [
    ./extensions.nix
    ./settings.nix
  ];

  programs.firefox = {
    enable = true;

    # Override the package, because default package doesn't support macOS.
    #
    # Note that [`firefox-bin`](https://github.com/bandithedoge/nixpkgs-firefox-darwin) is not universal,
    # so the default version is set for Linux
    package = if pkgs.stdenv.isDarwin then pkgs.firefox-bin else null;
  };

  # ! To workaround these issues:
  # ! https://github.com/bandithedoge/nixpkgs-firefox-darwin/issues/14
  # ! https://github.com/nix-community/home-manager/issues/3323;
  # !
  # ! Disabled because it doesn't work :D
  # ! But I'm gonna keep these comments for easy reference
  # home.sessionVariables.MOZ_LEGACY_PROFILES = "1";
}
