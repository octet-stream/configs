{ self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  zedModuleKey = self.lib.mkProgramModuleKey hostname username "zed";
  moduleKey = self.lib.mkModuleKey [
    zedModuleKey
    "settings"
  ];
in
{
  flake.modules.homeManager.${moduleKey} = {
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
