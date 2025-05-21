# VSCode setup managed by nix and home manager

{ ... }:
{
  imports = [
    ./settings.nix
    ./extensions.nix
  ];

  programs.vscode = {
    enable = true;

    # Prohibit to mutate extensions directory. It seem to break extensions sometimes.
    # See:
    # https://github.com/nix-community/home-manager/issues/3507
    # https://github.com/nix-community/home-manager/issues/4394
    mutableExtensionsDir = false;

    # General settings for default profile
    profiles.default = {
      enableUpdateCheck = false; # Disable VSCode self-update and let Home Manager to manage VSCode versions instead.
      enableExtensionUpdateCheck = false; # Disable extensions auto-update and let nix-vscode-extensions and nix4vscode manage updates and extensions
    };
  };
}
