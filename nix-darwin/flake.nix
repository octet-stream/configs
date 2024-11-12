{
  description = "My Nix Darwin flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{self, nix-darwin, nixpkgs}:
  let
    configuration = {pkgs, ...}: {
      nixpkgs.config.allowUnfree = true;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [
        vim
        fnm
        direnv
        bun
        deno
        rustup
        ookla-speedtest
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

      # Enable Touch ID auth authentication for sudo
      security.pam.enableSudoTouchIdAuth = true;

      homebrew = {
        enable = true;
        onActivation = {
          autoUpdate = true;
          upgrade = true;
          cleanup = "zap";
        };
        brews = [
          "git-extras"
          "mas" # Will be installed automatically if masApps has any App, but I'll have it installed ahead just in case if I remove the apps and still need this program
        ];
        casks = [
          # Browsers
          "firefox"
          "google-chrome"
          "tor-browser"

          # Code editors
          "visual-studio-code"
          "zed"

          # Dev tools
          "orbstack" # Docker Desktop alternative
          "linear-linear" # Projects management tool

          # Gaming
          "whisky" # Wine wrapper built with SwiftUI
          "openemu" # Retro consoles emulator

          # Video players
          "vlc"
          "iina"

          # DB Clients
          "db-browser-for-sqlite" # SQLite
          "sequel-ace" # MySQL and MariaDB

          # Others
          "lulu" # Firewall
          "topnotch" # Simply hides the notch ¯⁠\⁠_⁠(⁠ツ⁠)⁠_⁠/⁠¯
          "jordanbaird-ice" # Menu bar manager
          "appcleaner" # Uninstallation utility
          "discord" # Messenger
          "hot" # Temperature Sensors
          "inkscape" # SVG editor
          "qbittorrent" # BitTorrent client
        ];

        masApps = {
          Telegram = 747648890;
          Outline = 1356178125;
          Xcode = 497799835;
          Gifski = 1351639930;
          Lungo = 1263070803;
          Spark = 1176895641;
          "HEIC Converter" = 1294126402;
          "Color Picker" = 1545870783;
        };
      };
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#macbook-pro
    darwinConfigurations."macbook-pro" = nix-darwin.lib.darwinSystem {
      modules = [configuration];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."macbook-pro".pkgs;
  };
}
