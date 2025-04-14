{ self, config, ... }:
{
  imports = [
    ./programs
    ./packages
  ];
  home = {
    inherit (self.users.octetstream) username homeDirectory;

    stateVersion = "24.11";

    sessionVariables = {
      NH_FLAKE = config.programs.nh.flake; # TODO: This can be removed once home manager supports nh v4.x
      MOZ_LEGACY_PROFILES = "1"; # ! To workaround this issue: https://github.com/bandithedoge/nixpkgs-firefox-darwin/issues/14
    };
  };

  programs.home-manager.enable = true; # Allow Home Manager to manage itself;
}
