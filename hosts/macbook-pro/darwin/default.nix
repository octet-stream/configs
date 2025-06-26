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

  nix = {
    package = pkgs.nixVersions.latest; # Keep nix version in sync with specified package (for auto-updates)
    settings.experimental-features = "nix-command flakes"; # Enable flakes and nix command
  };

  nixpkgs = {
    config.allowUnfree = true;

    # Add overlays for nixpkgs to override some of the packages
    overlays = with self.inputs; [
      nix-vscode-extensions.overlays.default
      nix4vscode.overlays.forVscode
      nur.overlays.default
      zed-extensions.overlays.default

      # FIXME: Remove this once https://github.com/cachix/devenv/issues/1957 is resolved
      devenv.overlays.default
    ];
  };

  security.pam.services.sudo_local.touchIdAuth = true;
}
