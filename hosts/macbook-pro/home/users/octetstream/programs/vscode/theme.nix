{ config, lib, ... }:
lib.mkIf config.programs.vscode.enable {
  catppuccin.vscode.profiles.default = {
    enable = true;

    accent = "blue";

    settings = {
      # Disable italics
      italicKeywords = false;
      italicComments = false;
      workbenchMode = "flat";
    };
  };

  # VSCode settings overrides according to this plugin's recommendations
  programs.vscode.profiles.default.userSettings = {
    "editor.semanticHighlighting.enabled" = true;
    "terminal.integrated.minimumContrastRatio" = 1;
    "window.titleBarStyle" = "custom";
    "workbench.iconTheme" = "catppuccin-mocha";
  };
}
