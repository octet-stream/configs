{ inputs, ... }: {
  flake.modules.homeManager.vscode = { pkgsUnstable, lib, ... }: {
    # Adds vscode extensions overlays to `pkgs`
    imports = with inputs; [
      nix-vscode-extensions.overlays.default
      nix4vscode.overlays.forVscode
    ];

    programs.vscode = {
      enable = lib.mkDefault true;
      package = lib.mkDefault pkgsUnstable.vscode;

      # Disable VSCode self-update and let Home Manager to manage VSCode versions instead.
      profiles.default.enableUpdateCheck = false;

      # Make extension directory readonly, so VSCode cannot override it.
      # It seem to break extensions otherwise.
      #
      # See:
      # https://github.com/nix-community/home-manager/issues/3507
      # https://github.com/nix-community/home-manager/issues/4394
      mutableExtensionsDir = false;

      profiles.default = {
        # Disable extensions auto-update and let nix-vscode-extensions and nix4vscode manage updates and extensions
        enableExtensionUpdateCheck = false;
        userSettings."extensions.autoUpdate" = "off";
      };
    };
  };
}
