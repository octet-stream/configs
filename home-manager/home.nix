{ config, ... }:
{
  imports = [
    ./programs
    ./packages
  ];
  home = {
    inherit (import ../users/octetstream.nix) username homeDirectory;

    stateVersion = "24.11";

    sessionVariables = {
      NH_FLAKE = config.programs.nh.flake; # TODO: This can be removed once home manager supports nh v4.x
    };
  };

  programs.home-manager.enable = true; # Allow Home Manager to manage itself;
}
