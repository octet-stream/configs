{
  self,
  pkgs,
  ...
}:
{
  imports = [
    ./homebrew
    ./packages
    ./settings
  ];

  nix.settings.experimental-features = "nix-command flakes"; # Enable flakes and nix command;

  nixpkgs = {
    config.allowUnfree = true;

    # Add overlays for nixpkgs to override some of the packages
    overlays = with self.inputs; [
      nixpkgs-firefox-darwin.overlay
      nix-vscode-extensions.overlays.default
      nix4vscode.overlays.forVscode
      nur.overlays.default
      zed-extensions.overlays.default
    ];
  };

  security.pam.services.sudo_local.touchIdAuth = true;
}
