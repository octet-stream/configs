{ ... }:
{
  imports = [
    ./fixes
    ./extensions.nix
    ./settings.nix
  ];

  programs.firefox = {
    enable = true;
  };

  # ! To workaround these issues:
  # ! https://github.com/bandithedoge/nixpkgs-firefox-darwin/issues/14
  # ! https://github.com/nix-community/home-manager/issues/3323;
  # !
  # ! Disabled because it doesn't work :D
  # ! But I'm gonna keep these comments for easy reference
  # home.sessionVariables.MOZ_LEGACY_PROFILES = "1";
}
