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
    ui_font_size = 13;
    buffer_font_size = 13;

    base_keymap = "SublimeText";

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
