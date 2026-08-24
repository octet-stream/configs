{
  flake.modules.darwin.homebrew = { ... }: {
    homebrew.casks = [
      # Browsers
      "google-chrome" # ?: Maybe move it to Home Manager, same as Firefox

      # Dev tools
      "orbstack" # Docker Desktop alternative
      "linear" # Projects management tool
      "notion" # App to write, plan, collaborate, and get organised
      "postman"

      # Gaming
      "openemu" # Retro consoles emulator

      # DB Clients
      "db-browser-for-sqlite" # SQLite
      "sequel-ace" # MySQL and MariaDB
      "beekeeper-studio" # Multi-targeted SQL GUI client

      # Others
      "lulu" # Firewall
      "topnotch" # Simply hides the notch ¯⁠\⁠_⁠(⁠ツ⁠)⁠_⁠/⁠¯
      "appcleaner" # Uninstallation utility
      "discord" # Messenger
      "hot" # Temperature Sensors
      "qbittorrent" # BitTorrent client
      "keyboardcleantool" # Blocks all keyboard input when opened
      "thaw" # Menu bar manager

      # Broken
      # "inkscape" # SVG editor
    ];
  };
}
