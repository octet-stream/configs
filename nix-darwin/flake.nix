{
  description = "My Nix Darwin flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nix-darwin,
      home-manager,
      ...
    }:
    let
      configuration =
        { pkgs, ... }:
        {
          nixpkgs.config.allowUnfree = true;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";

          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = with pkgs; [
            git
            nixd # LSP for Nix
            nixfmt-rfc-style
            vim
            fnm # Node.js version manager written in Rust
            direnv
            bun
            deno
            rustup
            ookla-speedtest
            htop
            postgresql
          ];

          users.users.octetstream.home = "/Users/octetstream";
          home-manager.backupFileExtension = "backup";

          # Auto upgrade nix package and the daemon service.
          nix.package = pkgs.nixVersions.latest;

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Enable alternative shell support in nix-darwin.
          # programs.fish.enable = true;

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 5;

          system.defaults = {
            screencapture.location = "~/Pictures/Screencaps";
            loginwindow.GuestEnabled = false;
            dock = {
              mru-spaces = true;

              # List of the apps pinned in the Dock
              persistent-apps = [
                "/Applications/Firefox.app"
                "/Applications/Google Chrome.app"
                "/Applications/Spark.app"
                "/Applications/Telegram.app"
                "/Applications/Discord.app"

                # Figure out how to get this path dynamically, if there's a way
                "/Applications/Visual Studio Code.app"

                "/System/Applications/Music.app"
                "/System/Applications/Photos.app"
                "/System/Applications/Calendar.app"
                "/System/Applications/TV.app"
                "/Applications/iTerm.app"
                "/System/Applications/System Settings.app"
              ];
            };
            NSGlobalDomain = {
              AppleICUForce24HourTime = true;
              AppleInterfaceStyle = "Dark";
            };
          };

          # Enable Touch ID auth authentication for sudo
          # ! This is deprecated option. Replace it with the next line when 25.x branch is released
          security.pam.enableSudoTouchIdAuth = true;
          # security.pam.services.sudo_local.touchIdAuth = true;

          homebrew = {
            enable = true;
            onActivation = {
              autoUpdate = true;
              upgrade = true;
              cleanup = "zap";
            };
            brews = [
              "git-extras"
              "pulumi"
              "mysql"
            ];
            casks = [
              # Browsers
              "firefox"
              "google-chrome"
              "tor-browser"

              # Terminal emulators
              "iterm2"
              "ghostty"

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
      # Or build & switch using:
      # $ darwin-rebuild switch --flake .#macbook-pro
      darwinConfigurations."macbook-pro" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration

          home-manager.darwinModules.home-manager

          {
            home-manager = {
              extraSpecialArgs = { inherit self; };
              backupFileExtension = "backup";
              useGlobalPkgs = true;
              useUserPackages = true;
              users.octetstream = import ./home.nix;
            };
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."macbook-pro".pkgs;
    };
}
