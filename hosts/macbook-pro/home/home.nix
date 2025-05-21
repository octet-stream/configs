{ self, ... }:
{
  imports = [
    ./programs
    ./packages
  ];
  home = {
    inherit (self.users.octetstream) username homeDirectory;

    stateVersion = "24.11";
  };

  programs.home-manager.enable = true; # Allow Home Manager to manage itself;

  # Set theme flavor
  catppuccin.flavor = "mocha";
}
