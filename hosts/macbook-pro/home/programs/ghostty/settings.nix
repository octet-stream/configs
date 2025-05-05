# Ghostty settings
#
# For more information on how to configure Ghostty,
# check out documentation: https://ghostty.org/docs/config/reference#theme

# ! Note: Remove ~/Library/Application\ Support/com.mitchellh.ghostty/config file if it exists, otherwise it will be loaded and break the whole configuration
# ! See: https://github.com/ghostty-org/ghostty/discussions/5687

{ ... }:
{
  programs.ghostty.settings = {
    auto-update = "off";
    theme = "Snazzy";

    # Window size
    window-width = 90;
    window-height = 20;

    # Cursor
    cursor-style = "bar";
    cursor-style-blink = false;
    shell-integration-features = "no-cursor"; # Disable shell integration for cursor, otherwise it will not pick up my settings
  };
}
