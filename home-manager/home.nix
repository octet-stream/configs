{ ... }:
{
  imports = [
    ./vscode
    ./zsh
    ./direnv
  ];
  home = {
    username = "octetstream";
    homeDirectory = "/Users/octetstream";
    stateVersion = "24.11";

    sessionPath = [
      "/run/current-system/sw/bin"
      "$HOME/.nix-profile/bin"
    ];
  };

  programs.home-manager.enable = true; # Allow Home Manager to manage itself;
}
