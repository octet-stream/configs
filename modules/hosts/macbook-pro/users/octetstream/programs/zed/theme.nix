{ self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  zedModuleKey = self.lib.mkProgramModuleKey hostname username "zed";
  moduleKey = self.lib.mkModuleKey [
    zedModuleKey
    "theme"
  ];
in
{
  flake.modules.homeManager.${moduleKey} =
    {
      config,
      lib,
      pkgs,
      utils,
      ...
    }:
    let
      inherit (config.catppuccin) sources;

      cfg = config.catppuccin;
      accent = if cfg.accent == "mauve" then "" else " (${cfg.accent})";
      flavor = if cfg.flavor == "frappe" then "Frappé" else utils.capitalize cfg.flavor;
    in
    lib.mkIf config.programs.zed-editor.enable {
      programs.zed-editor.userSettings = {
        theme = {
          mode = "system";
          light = "Catppuccin Latte${accent} - No Italics";
          dark = "Catppuccin ${flavor}${accent} - No Italics";
        };

        icon_theme = {
          mode = "system";
          light = "Catppuccin Latte";
          dark = "Catppuccin Mocha";
        };
      };

      programs.zed-editor-extensions.packages = with pkgs.zed-extensions; [ catppuccin-icons ];

      xdg.configFile."zed/themes/catppuccin.json".source =
        "${sources.zed}/catppuccin-no-italics-${cfg.accent}.json";
    };
}
