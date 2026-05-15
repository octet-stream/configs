# VSCode setup managed by nix and home manager

{ pkgsUnstable, ... }:
{
  imports = [
    ./extensions.nix
    ./keybindings.nix
    ./settings.nix
    ./theme.nix
  ];

  programs.vscode = {
    enable = true;
    package = pkgsUnstable.vscode;

    # General settings for default profile
    profiles.default.enableUpdateCheck = false; # Disable VSCode self-update and let Home Manager to manage VSCode versions instead.;
  };
}
