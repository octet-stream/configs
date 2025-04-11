{
  self,
  system,
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
    hostPlatform = system;

    # Add overlays for nixpkgs to override some of the packages
    overlays = [
      self.inputs.nix-vscode-extensions.overlays.default
      self.inputs.nix4vscode.overlays.forVscode
      self.inputs.nh.overlays.default
      self.inputs.nur.overlays.default
      self.inputs.firefox-darwin.overlay
    ];
  };

  users.users.${user.username}.home = user.homeDirectory;

  # Enable Touch ID auth authentication for sudo
  # ! This is deprecated option. Replace it with the next line when 25.x branch is released
  security.pam.enableSudoTouchIdAuth = true;
  # security.pam.services.sudo_local.touchIdAuth = true;
}
