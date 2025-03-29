{
  self,
  config,
  pkgs,
  ...
}:
let
  homeRoot = "/Users/octetstream";

  prependAppsPath = builtins.map (name: /Applications/${name});

  prependSystemAppsPath = builtins.map (name: /System/Applications/${name});

  preprendHomeManagerAppsPath = builtins.map (
    name: "${homeRoot}/Applications/Home Manager Apps/${name}"
  );
in
{
  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = "aarch64-darwin";

    overlays = [
      self.inputs.nix-vscode-extensions.overlays.default
      self.inputs.nix4vscode.overlays.forVscode
      self.inputs.nh.overlays.default
    ];
  };

  # TODO: Deduplicate username and home directory definitions
  users.users.octetstream.home = homeRoot;

  networking = {
    computerName = "Nick's Macbook Pro";
    hostName = "macbook-pro";
  };

  # Auto upgrade nix package and the daemon service using version from this package.
  nix.package = pkgs.nixVersions.latest;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Enable Touch ID auth authentication for sudo
  # ! This is deprecated option. Replace it with the next line when 25.x branch is released
  security.pam.enableSudoTouchIdAuth = true;
  # security.pam.services.sudo_local.touchIdAuth = true;

  system = {
    configurationRevision = self.rev or self.dirtyRev or null;
    stateVersion = 5;

    defaults = {
      screencapture.location = "~/Pictures/Screencaps";
      loginwindow.GuestEnabled = false;

      dock = {
        autohide = false; # always display dock
        mru-spaces = false; # disable spaces rearrangement based on recent apps use
        show-recents = false; # do not show recently closed apps

        # List of pinned applications
        persistent-apps =
          [ ]

          ++ prependAppsPath [
            "Firefox.app"
            "Google Chrome.app"
            "Spark.app"
            "Telegram.app"
            "Discord.app"
            # "Visual Studio Code.app"
          ]

          ++ preprendHomeManagerAppsPath [ "Visual Studio Code.app" ]

          ++ prependSystemAppsPath [
            "Music.app"
            "Photos.app"
            "Calendar.app"
            "TV.app"
          ]

          ++ prependAppsPath [ "iTerm.app" ]
          ++ prependSystemAppsPath [ "System Settings.app" ];
      };

      NSGlobalDomain = {
        AppleICUForce24HourTime = true; # Force time format to 24h
        AppleInterfaceStyle = "Dark"; # Use dark theme
      };
    };
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # or visit https://search.nixos.org
  # TODO: Move system packages into its own module
  environment.systemPackages = with pkgs; [
    # essentials
    git
    htop

    # nix-related stuff
    nixd # LSP for Nix
    nixfmt-rfc-style

    # Note: nh is disabled because it does not support darwin-nix yet
    nh
    nix-output-monitor
    nvd
  ];

  # Homebrew _installation_ configuration
  nix-homebrew = {
    enable = true;
    mutableTaps = false;
    autoMigrate = true;
    enableRosetta = true;
    user = "octetstream";

    taps = {
      "homebrew/homebrew-core" = self.inputs.homebrew-core;
      "homebrew/homebrew-cask" = self.inputs.homebrew-cask;
    };
  };

  # Homebrew configuration & packages
  homebrew = {
    enable = true;
    global.autoUpdate = false;

    onActivation = {
      upgrade = true;
      cleanup = "zap";
    };

    # Repositories
    taps = builtins.attrNames config.nix-homebrew.taps;

    # Packages
    brews = [
      "git-extras" # TODO: Install it from nixpkgs instead
      "pulumi" # This one is up-to-date, unlike in nixpkgs
      "mysql" # This was is missing from nixpkgs
    ];

    # Apps
    casks = [
      # Browsers
      "firefox" # TODO: Move Fixfox to Home Manager
      "google-chrome" # TODO: Figure out how to manage extensions from home-manager or nix, maybe?
      "tor-browser"

      # Terminal emulators
      "iterm2"
      "ghostty" # TODO: Move it to home-manager

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

    # Mac AppStore apps managed by MAS
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
}
