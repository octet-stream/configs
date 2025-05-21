# Custom catppuccin theme configutation module for zed based on https://github.com/catppuccin/nix/blob/3ba714046ee32373e88166e6e9474d6ae6a5b734/modules/home-manager/zed-editor.nix
#
# This module is not configurable and will be always enabled if Zed is enabled.
# It re-implements catppuccin module linked above so I can utilize zed-extensions flake to manage icons.

{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (config.catppuccin) sources;
  inherit (lib) toUpper substring stringLength;

  mkCapitalize = str: (toUpper (substring 0 1 str)) + (substring 1 (stringLength str) str);

  cfg = config.catppuccin;
  enable = config.programs.zed-editor.enable;

  accent = if cfg.accent == "mauve" then "" else " (${cfg.accent})";
  flavor = if cfg.flavor == "frappe" then "Frappé" else mkCapitalize cfg.flavor;
in
lib.mkIf enable {
  programs.zed-editor.userSettings = {
    theme = {
      mode = "system";
      light = "Catppuccin Latte" + accent + " - No Italics";
      dark = "Catppuccin " + flavor + accent + " - No Italics";
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
}
