# VSCode setup managed by nix and home manager

{
  imports = [
    ./extensions.nix
    ./keybindings.nix
    ./settings.nix
    ./theme.nix
  ];

  programs.vscode = {
    enable = true;

    # General settings for default profile
    profiles.default.enableUpdateCheck = false; # Disable VSCode self-update and let Home Manager to manage VSCode versions instead.;
  };
}
