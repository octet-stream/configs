{ inputs, ... }:
let
  extensionsOverlay = {
    nixpkgs.overlays = [
      inputs.nix-vscode-extensions.overlays.default
      inputs.nix4vscode.overlays.forVscode
    ];
  };
in
{
  # Makes extensions available under `pkgs.vscode-marketplace-release` and `pkgs.nix4vscode`.
  flake.modules.darwin.vscode = extensionsOverlay;
  flake.modules.nixos.vscode = extensionsOverlay;

  flake.modules.homeManager.vscode =
    { lib, pkgsUnstable, ... }:
    {
      programs.vscode = {
        enable = lib.mkDefault true;
        package = lib.mkDefault pkgsUnstable.vscode;

        # Keep VSCode and its extensions fully managed by Nix.
        mutableExtensionsDir = false;
        profiles.default = {
          enableUpdateCheck = false;
          enableExtensionUpdateCheck = false;
          userSettings."extensions.autoUpdate" = "off";
        };
      };
    };
}
