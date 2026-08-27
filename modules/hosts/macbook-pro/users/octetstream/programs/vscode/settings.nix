{ self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  vscodeModuleKey = self.lib.mkProgramModuleKey hostname username "vscode";
  moduleKey = self.lib.mkModuleKey [
    vscodeModuleKey
    "settings"
  ];
in
{
  flake.modules.homeManager.${moduleKey} = {
    programs.vscode.profiles.default.userSettings = {
      "window.newWindowDimensions" = "inherit";
      "breadcrumbs.enabled" = false;

      "editor.minimap.enabled" = false;
      "editor.renderWhitespace" = "all";
      "editor.cursorBlinking" = "solid";
      "editor.tabSize" = 2;
      "editor.bracketPairColorization.independentColorPoolPerBracketType" = true;
      "editor.stickyScroll.enabled" = false;
      "editor.linkedEditing" = true;

      "workbench.startupEditor" = "none";

      "nix.serverPath" = "nixd";
      "nix.enableLanguageServer" = true;
      "nix.serverSettings".nixd.formatting.command = [ "nixfmt" ];
      "nixEnvSelector.suggestion" = false;

      "files.associations"."flake.lock" = "json";
      "[markdown]"."editor.wordWrap" = "off";

      "typescript.updateImportsOnFileMove.enabled" = "always";

      "emmet.triggerExpansionOnTab" = true;
      "emmet.includeLanguages".astro = "html";

      "window.commandCenter" = false;
      "chat.commandCenter.enabled" = false;
      "chat.agent.enabled" = false;
      "workbench.editor.empty.hint" = "hidden";
      "terminal.integrated.initialHint" = false;
      "telemetry.feedback.enabled" = false;

      "redhat.telemetry.enabled" = false;
      "yaml.disableSchemaDetection" = [
        "**/.github/workflows/*.yml"
        "**/.github/workflows/*.yaml"
        "**/.gitea/workflows/*.yml"
        "**/.gitea/workflows/*.yaml"
        "**/.forgejo/workflows/*.yml"
        "**/.forgejo/workflows/*.yaml"
      ];

      "oxc.requireConfig" = true;
    };
  };
}
