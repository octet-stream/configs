{ config, ... }:
{
  imports = [
    ./programs
    ./packages
  ];
  home = {
    # TODO: Dedupe all user and home directory references
    username = "octetstream";
    homeDirectory = "/Users/octetstream";

    stateVersion = "24.11";

    sessionVariables = {
      NH_FLAKE = config.programs.nh.flake; # TODO: This can be removed once
    };
  };

  programs.home-manager.enable = true; # Allow Home Manager to manage itself;
}
