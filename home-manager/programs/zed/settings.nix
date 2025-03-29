# Zed settings
#
# For information on how to configure Zed, see the Zed
# documentation: https://zed.dev/docs/configuring-zed
#
# To see all of Zed's default settings without changing your
# custom settings, run `zed: open default settings` from the
# command palette (in Zed) cmd-shift-p / ctrl-shift-p

{ ... }:
{
  programs.zed-editor.userSettings = {
    auto_update = false; # Disable auto updates to let home manager do the job
    ui_font_size = 13;
    buffer_font_size = 13;

    # Always render whitespaces, same as in VSCode
    show_whitespaces = "all";

    # Use keymap from Sublime Text
    base_keymap = "SublimeText";

    # Cursor settings with the same settings as I use for VSCode
    cursor_blink = false;
    cursor_shape = "bar";

    # Use the same size as VSCode
    tab_size = 2;

    theme = {
      mode = "dark";
      light = "One Light";
      dark = "Night Owl No Italics";
    };

    features = {
      copilot = false;
    };
  };
}
