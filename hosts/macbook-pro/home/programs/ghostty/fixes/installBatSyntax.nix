# ! Fixes bat support for ghostty syntax linking on macOS

{
  lib,
  pkgs,
  config,
  ...
}:
lib.mkIf pkgs.stdenv.isDarwin {
  programs = {
    ghostty.installBatSyntax = false;
    bat = {
      config.map-syntax = [ "${config.xdg.configHome}/ghostty/config:Ghostty Config" ];

      syntaxes.ghostty = {
        src = config.programs.ghostty.package;
        file = "Applications/Ghostty.app/Contents/Resources/bat/syntaxes/ghostty.sublime-syntax";
      };
    };
  };
}
