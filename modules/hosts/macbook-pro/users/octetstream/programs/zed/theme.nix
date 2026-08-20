{ ... }:
let
  username = "octetstream";
  zedModule = "hosts/macbook-pro/users/${username}/zed";
in
{
  flake.modules.homeManager."${zedModule}/theme" =
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
