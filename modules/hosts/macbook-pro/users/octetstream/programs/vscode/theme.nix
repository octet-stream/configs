{ self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  vscodeModuleKey = self.lib.mkProgramModuleKey hostname username "vscode";
  moduleKey = self.lib.mkModuleKey [
    vscodeModuleKey
    "theme"
  ];
in
{
  flake.modules.homeManager.${moduleKey} =
    { config, lib, ... }:
    lib.mkIf config.programs.vscode.enable {
      catppuccin.vscode.profiles.default = {
        enable = true;
        accent = "blue";
        settings = {
          italicKeywords = false;
          italicComments = false;
          workbenchMode = "flat";
        };
      };

      programs.vscode.profiles.default.userSettings = {
        "editor.semanticHighlighting.enabled" = true;
        "terminal.integrated.minimumContrastRatio" = 1;
        "window.titleBarStyle" = "custom";
        "workbench.iconTheme" = "catppuccin-mocha";
      };
    };
}
