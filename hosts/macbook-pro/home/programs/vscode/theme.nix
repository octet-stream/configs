{ ... }:
{
  catppuccin.vscode = {
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
  };
}
