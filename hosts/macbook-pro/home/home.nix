{ self, inputs, ... }:
{
  imports = with inputs; [
    # Catppuccin theme utilities for Nix to simplify installation and customization
    catppuccin.homeModules.catppuccin

    # # Zed extensions managed by Nix
    # zed-extensions.homeManagerModules.default

    ./programs
    ./packages
  ];
  home = {
    inherit (self.users.octetstream) username homeDirectory;

    stateVersion = "24.11";
  };

  programs.home-manager.enable = true; # Allow Home Manager to manage itself;

  # Set theme flavor and accent
  catppuccin = {
    flavor = "mocha";
    accent = "blue";
  };
}
