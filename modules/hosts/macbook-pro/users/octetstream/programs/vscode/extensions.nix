{ self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  vscodeModuleKey = self.lib.mkProgramModuleKey hostname username "vscode";
  moduleKey = self.lib.mkModuleKey [
    vscodeModuleKey
    "extensions"
  ];
in
{
  flake.modules.homeManager.${moduleKey} =
    { pkgs, ... }:
    let
      marketplaceExtensions = with pkgs.vscode-marketplace-release; [
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
        typescriptteam.native-preview
      ];

      nix4vscodeExtensions = pkgs.nix4vscode.forVscode [
        "ms-vscode-remote.remote-containers"
        "tamasfe.even-better-toml"
        "mads-hartmann.bash-ide-vscode"
        "redhat.vscode-yaml"
        "catppuccin.catppuccin-vsc-icons"
        "oxc.oxc-vscode"
        "zenstack.zenstack"
        "prisma.prisma"
        "bradlc.vscode-tailwindcss"
        "qufiwefefwoyn.inline-sql-syntax"
      ];
    in
    {
      programs.vscode.profiles.default.extensions = marketplaceExtensions ++ nix4vscodeExtensions;
    };
}
