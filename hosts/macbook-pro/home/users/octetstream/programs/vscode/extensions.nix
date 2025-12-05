# Extensions list and VSCode settings for extensions

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
  programs.vscode = {
    # Make extension directory readonly, so VSCode cannot override it.
    # It seem to break extensions otherwise.
    #
    # See:
    # https://github.com/nix-community/home-manager/issues/3507
    # https://github.com/nix-community/home-manager/issues/4394
    mutableExtensionsDir = false;

    profiles.default = {
      # Disable extensions auto-update and let nix-vscode-extensions and nix4vscode manage updates and extensions
      enableExtensionUpdateCheck = false;
      userSettings."extensions.autoUpdate" = false;

      extensions = defaultSource ++ backupSource;
    };
  };
}
