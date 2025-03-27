{ pkgs, ... }:
{
  config = {
    programs.vscode = {
      enable = true;
      enableUpdateCheck = false; # Disable VSCode self-update and let Home Manager to manage VSCode versions instead.
      enableExtensionUpdateCheck = false; # Disable extensions auto-update and let nix-vscode-extensions and nix4vscode manage updates and extensions

      # List of VSCode extensions managed by Nix sourced from nix-vscode-extensions and nix4vscode.
      extensions =
        with pkgs.vscode-marketplace;
        [ ]

        # Some extensions from this repo may break VSCode. If that happens - try and move them to the second list one by one
        ++ [
          aaron-bond.better-comments
          ahmadalli.vscode-nginx-conf
          arrterian.nix-env-selector
          astro-build.astro-vscode
          bierner.lit-html
          biomejs.biome
          bradlc.vscode-tailwindcss
          dbaeumer.vscode-eslint
          editorconfig.editorconfig
          firefox-devtools.vscode-firefox-debug
          github.vscode-github-actions
          graphql.vscode-graphql
          graphql.vscode-graphql-syntax
          jnoortheen.nix-ide
          mkhl.direnv
          ms-azuretools.vscode-docker
          ms-vscode.sublime-keybindings
          orta.vscode-twoslash-queries
          pinage404.nix-extension-pack
          sdras.night-owl
          styled-components.vscode-styled-components
          unifiedjs.vscode-mdx
          vue.volar
          yoavbls.pretty-ts-errors
        ]

        ++ pkgs.forVscode [
          "ms-vscode-remote.remote-containers.0.397.0"
          "tamasfe.even-better-toml"
        ];

      userSettings = {
        "editor.minimap.enabled" = false;
        "editor.renderWhitespace" = "all";
        "breadcrumbs.enabled" = false;
        "editor.cursorBlinking" = "solid";
        "window.commandCenter" = false;
        "editor.tabSize" = 2;
        "editor.bracketPairColorization.independentColorPoolPerBracketType" = true;
        "editor.stickyScroll.enabled" = false;
        "workbench.startupEditor" = "none";
        "nix.serverPath" = "nixd";
        "nix.enableLanguageServer" = true;
        "nix.serverSettings" = {
          nixd.formatting.command = [ "nixfmt" ];
        };
        "files.associations" = {
          "flake.lock" = "json";
        };
        "[markdown]" = {
          "editor.wordWrap" = "off";
        };
        "typescript.updateImportsOnFileMove.enabled" = "always";
        "workbench.colorTheme" = "Night Owl (No Italics)";
        "emmet.triggerExpansionOnTab" = true;
        "emmet.includeLanguages" = {
          "astro" = "html";
        };
        "chat.commandCenter.enabled" = false; # Disable copilot
      };
    };
  };
}
