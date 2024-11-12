{
  description = "My Nix Darwin flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{self, nix-darwin, nixpkgs, home-manager}:
  let
    configuration = {pkgs, config, ...}: {
      nixpkgs.config.allowUnfree = true;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [
        mkalias
        vim
        fnm
        direnv
        bun
        deno
        rustup
        ookla-speedtest

        # VSCode and extensions
        (vscode-with-extensions.override {
          vscodeExtensions = with vscode-extensions; [
            jnoortheen.nix-ide
            ms-vscode-remote.remote-containers
            biomejs.biome
            astro-build.astro-vscode
            editorconfig.editorconfig
            sdras.night-owl
          ];
        })
      ];

      users.users.octetstream.home = "/Users/octetstream";
      home-manager.backupFileExtension = "backup";

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      nix.package = pkgs.nix;

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
        dock.mru-spaces = true;
        screencapture.location = "~/Pictures/Screencaps";
      };

      # Activation script for macOS aliases
      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
      pkgs.lib.mkForce ''
        echo "setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read -r src; do
          app_name=$(basename "$src")
          echo "copying $src" >&2
          ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        done
      '';

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
          # "visual-studio-code"
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
      modules = [
        configuration

        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.octetstream = import ./home.nix;
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."macbook-pro".pkgs;
  };
}
