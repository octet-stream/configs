# List of VSCode extensions managed by Nix sourced from nix-vscode-extensions and nix4vscode.

{ pkgs, ... }:
{
  programs.vscode.profiles.default.extensions =
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
      ms-vscode.sublime-keybindings
      orta.vscode-twoslash-queries
      pinage404.nix-extension-pack
      sdras.night-owl
      styled-components.vscode-styled-components
      unifiedjs.vscode-mdx
      vue.volar
      yoavbls.pretty-ts-errors
      ms-azuretools.vscode-containers
    ]

    ++ pkgs.nix4vscode.forVscode [
      "ms-vscode-remote.remote-containers"
      "tamasfe.even-better-toml"
      "mads-hartmann.bash-ide-vscode"
      "redhat.vscode-yaml"
      "waderyan.gitblame"
    ];
}
