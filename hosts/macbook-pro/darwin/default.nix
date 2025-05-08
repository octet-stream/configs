{
  self,
  pkgs,
  ...
}:
let
  user = self.users.octetstream;
in
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
      firefox-darwin.overlay
      zed-extensions.overlays.default
    ];
  };

  users.users.${user.username}.home = user.homeDirectory;

  # Enable Touch ID authorization for sudo
  # ! This is deprecated option. Replace it with the next line when 25.x branch is released
  security.pam.enableSudoTouchIdAuth = true;
  # security.pam.services.sudo_local.touchIdAuth = true;
}
