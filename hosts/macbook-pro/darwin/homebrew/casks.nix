{ ... }:
{
  homebrew.casks = [
    # Browsers
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
    "desktoppr" # Sets wallpapers via command line
    "keyboardcleantool" # Blocks all keyboard input when opened
  ];
}
