{ ... }:
let
  username = "octetstream";
  zedModule = "hosts/macbook-pro/users/${username}/zed";
in
{
  flake.modules.homeManager."${zedModule}/settings" = {
    programs.zed-editor.userSettings = {
      buffer_font_size = 13;
      buffer_font_family = "Menlo";
      buffer_font_fallbacks = [
        "Monaco"
        "Courier New"
      ];

      ui_font_size = 13;
      ui_font_family = "Menlo";
      ui_font_fallbacks = [
        "Monaco"
        "Courier New"
      ];

      show_whitespaces = "all";
      base_keymap = "SublimeText";
      cursor_blink = false;
      cursor_shape = "bar";
      tab_size = 2;

      features.copilot = false;

      languages.Nix.language_servers = [
        "nixd"
        "!nil"
      ];

      vim_mode = true;
      vim.default_mode = "insert";
    };
  };
}
