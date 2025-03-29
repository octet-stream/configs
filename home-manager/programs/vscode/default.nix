# VSCode setup managed by nix and home manager

{ ... }:
{
  imports = [
    ./settings.nix
    ./extensions.nix
  ];

  programs.vscode = {
    enable = true;
    enableUpdateCheck = false; # Disable VSCode self-update and let Home Manager to manage VSCode versions instead.
    enableExtensionUpdateCheck = false; # Disable extensions auto-update and let nix-vscode-extensions and nix4vscode manage updates and extensions
  };
}
