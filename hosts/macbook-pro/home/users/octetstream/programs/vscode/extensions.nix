# Extensions list and VSCode settings for extensions

{ pkgs, ... }:
let
  # Extensions from nix-vscode-extensions overlay
  vscMarketplaceSource = with pkgs.vscode-marketplace-release; [
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
    waderyan.gitblame
    graphql.vscode-graphql
    graphql.vscode-graphql-syntax
  ];

  # Extensions from nix4vscode overlay
  nix4VSCodeSource = pkgs.nix4vscode.forVscode [
    "ms-vscode-remote.remote-containers"
    "tamasfe.even-better-toml"
    "mads-hartmann.bash-ide-vscode"
    "redhat.vscode-yaml"
    "catppuccin.catppuccin-vsc-icons"
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

      extensions = vscMarketplaceSource ++ nix4VSCodeSource;
    };
  };
}
