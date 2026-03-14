{
  self,
  pkgsUnstable,
  ...
}:
{
  imports = [
    ./homebrew
    ./packages
    ./settings
  ];

  # ! Trying out nix v2.34.x and hope it will fix the problem with "Too many open files" on macOS: https://github.com/NixOS/nix/pull/15205
  # ! Switch back to stable branch as soon as v2.34.x is available there!
  nix.package = pkgsUnstable.nixVersions.latest;

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
