{ self, ... }:
let
  moduleKey = self.lib.mkModuleKey [
    (self.lib.mkProgramModuleKey "macbook-pro" "octetstream" "ghostty")
    "settings"
  ];
in
{
  # Remove ~/Library/Application Support/com.mitchellh.ghostty/config if it
  # exists: Ghostty loads it alongside the Home Manager-managed XDG config.
  # See: https://github.com/ghostty-org/ghostty/discussions/5687
  flake.modules.homeManager.${moduleKey} = {
    programs.ghostty.settings = {
      working-directory = "home";
      window-inherit-working-directory = false;

      window-width = 90;
      window-height = 20;

      cursor-style = "block_hollow";
      cursor-style-blink = false;

      # Keep Ghostty's shell integration from overriding the cursor settings.
      shell-integration-features = "no-cursor";
    };
  };
}
