{
  description = "My Nix Darwin flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = [
        pkgs.vim
        pkgs.fnm
        pkgs.direnv
      ];

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      # Enable Touch ID auth authentication for sudo
      security.pam.enableSudoTouchIdAuth = true;

      homebrew = {
        enable = true;
        onActivation = {
          autoUpdate = true;
          upgrade = true;
        };
        brews = [
          "git-extras"
        ];
        casks = [
          # Browsers
          "firefox"
          "google-chrome"
          "tor-browser"

          "orbstack" # Docker Desktop alternative
          "linear-linear" # Projects management tool
          "lulu" # Firewall
          "topnotch" # Simply hides the notch ¯⁠\⁠_⁠(⁠ツ⁠)⁠_⁠/⁠¯
          "jordanbaird-ice" # Menu bar manager
          "visual-studio-code" # Code editor
          "appcleaner" # Uninstallation utility
          "discord" # Messenger
          "hot" # Temperature Sensors
          "inkscape" # SVG editor
          "openemu" # Retro consoles emulator
          "qbittorrent" # BitTorrent client
          "whisky" # Wine wrapper built with SwiftUI

          # Video players
          "vlc"
          "iina"

          # DB Clients
          "db-browser-for-sqlite" # SQLite
          "sequel-ace" # MySQL and MariaDB
        ];
      };
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#macbook-pro
    darwinConfigurations."macbook-pro" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."macbook-pro".pkgs;
  };
}
