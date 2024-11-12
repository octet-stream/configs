{config, pkgs, ...}:

{
  # home.username = "octetstream";
  # home.homeDirectory = "/Users/octetstream";
  # home.stateVersion = "23.05";

  # home.packages = [];

  home = {
    username = "octetstream";
    homeDirectory = "/Users/octetstream";
    stateVersion = "23.05";

    # User-specific packages not available system-wide
    packages = [];

    sessionVariables = {};

    sessionPath = [
      "/run/current-system/sw/bin"
      "$HOME/.nix-profile/bin"
    ];
  };

  programs = {
    home-manager.enable = true;
  };
}
