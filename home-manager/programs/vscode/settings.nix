{ ... }:
{
  programs.vscode.userSettings = {
    "window.newWindowDimensions" = "inherit"; # Sets window to preverve the size from the last session
    "breadcrumbs.enabled" = false;

    # Editor settings
    "editor.minimap.enabled" = false;
    "editor.renderWhitespace" = "all";
    "editor.cursorBlinking" = "solid";
    "editor.tabSize" = 2;
    "editor.bracketPairColorization.independentColorPoolPerBracketType" = true;
    "editor.stickyScroll.enabled" = false;

    # Workbench settings
    "workbench.colorTheme" = "Night Owl (No Italics)";
    "workbench.startupEditor" = "none";

    # Nix IDE settings
    "nix.serverPath" = "nixd";
    "nix.enableLanguageServer" = true;
    "nix.serverSettings" = {
      nixd.formatting.command = [ "nixfmt" ];
    };

    "files.associations" = {
      "flake.lock" = "json"; # VSCode doesn't recognize flake.lock as JSON by default even with Nix IDE installed
    };

    "[markdown]" = {
      "editor.wordWrap" = "off"; # This has to be turned off separately for MD files for some reason
    };

    "typescript.updateImportsOnFileMove.enabled" = "always";

    # Emmet settings
    "emmet.triggerExpansionOnTab" = true;
    "emmet.includeLanguages" = {
      "astro" = "html";
    };

    "window.commandCenter" = false; # Disables command center panel on the top
    "chat.commandCenter.enabled" = false; # Disable copilot
  };
}
