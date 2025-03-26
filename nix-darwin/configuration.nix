{ self, pkgs, ... }:
{
  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = "aarch64-darwin";
  };

  users.users.octetstream.home = "/Users/octetstream";

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

  # Homebrew configuration
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
    brews = [
      "git-extras" # TODO: Install it from nixpkgs instead
      "pulumi" # This one is up-to-date, unlike in nixpkgs
      "mysql" # This was is missing from nixpkgs
    ];
    casks = [
      # Browsers
      "firefox" # TODO: Move Fixfox to Home Manager
      "google-chrome" # TODO: Figure out how to manage extensions from home-manager or nix, maybe?
      "tor-browser"

      # Terminal emulators
      "iterm2"
      "ghostty" # TODO: Move it to home-manager

      # Code editors
      "visual-studio-code" # TODO: Find a good and stable way to manage extensidons and settings from Nix
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
}
