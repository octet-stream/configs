# List of VSCode extensions managed by Nix sourced from nix-vscode-extensions and nix4vscode.

{ pkgs, ... }:
let
  # Extensions from nix-vscode-extensions overlay
  defaultSource = with pkgs.vscode-marketplace; [
    aaron-bond.better-comments
    ahmadalli.vscode-nginx-conf
    astro-build.astro-vscode
    bierner.lit-html
    biomejs.biome
    dbaeumer.vscode-eslint
    editorconfig.editorconfig
    firefox-devtools.vscode-firefox-debug
    github.vscode-github-actions
    jnoortheen.nix-ide
    ms-vscode.sublime-keybindings
    orta.vscode-twoslash-queries
    styled-components.vscode-styled-components
    unifiedjs.vscode-mdx
    vue.volar
    yoavbls.pretty-ts-errors
    ms-azuretools.vscode-containers
  ];

  # Extensions from nix4vscode
  backupSource = pkgs.nix4vscode.forVscode [
    "ms-vscode-remote.remote-containers"
    "tamasfe.even-better-toml"
    "mads-hartmann.bash-ide-vscode"
    "redhat.vscode-yaml"
    "waderyan.gitblame"
    "catppuccin.catppuccin-vsc-icons"
    "graphql.vscode-graphql"
    "graphql.vscode-graphql-syntax"
    "oxc.oxc-vscode"
    "zenstack.zenstack"
    "prisma.prisma"
    "bradlc.vscode-tailwindcss"
  ];
in
{
  programs.vscode.profiles.default = {
    userSettings."extensions.autoUpdate" = false;

    extensions = defaultSource ++ backupSource;
  };
}
