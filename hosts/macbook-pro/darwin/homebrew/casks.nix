{
  homebrew.casks = [
    # Browsers
    "google-chrome" # ?: Maybe move it to Home Manager, same as Firefox
    "tor-browser"

    # Terminal emulators
    "iterm2"

    # Dev tools
    "orbstack" # Docker Desktop alternative
    "container" # Apple's docker-like containerization
    "linear" # Projects management tool
    "notion" # App to write, plan, collaborate, and get organised

    # Gaming
    "openemu" # Retro consoles emulator

    # Video players
    "iina"

    # DB Clients
    "db-browser-for-sqlite" # SQLite
    "sequel-ace" # MySQL and MariaDB
    "beekeeper-studio" # Multi-targeted SQL GUI client

    # Others
    "lulu" # Firewall
    "topnotch" # Simply hides the notch ¯⁠\⁠_⁠(⁠ツ⁠)⁠_⁠/⁠¯
    "jordanbaird-ice" # Menu bar manager
    "appcleaner" # Uninstallation utility
    "discord" # Messenger
    "hot" # Temperature Sensors
    "qbittorrent" # BitTorrent client
    "desktoppr" # Sets wallpapers via command line
    "keyboardcleantool" # Blocks all keyboard input when opened
    "postman"

    # Broken
    # "inkscape" # SVG editor
  ];
}
