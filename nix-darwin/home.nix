{config, pkgs, ...}:

{
  home = {
    username = "octetstream";
    homeDirectory = "/Users/octetstream";
    stateVersion = "23.05";

    # User-specific packages not available system-wide
    packages = [];

    sessionVariables = {};

    sessionPath = [
      "/run/current-system/sw/bin"
      "$HOME/.nix-profile/bin"
    ];
  };

  programs = {
    home-manager.enable = true;
    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        ms-vscode-remote.remote-containers
        biomejs.biome
        astro-build.astro-vscode
        editorconfig.editorconfig
        sdras.night-owl
        # Find a way to install this extension:
        # ms-vscode.sublime-keybindings
        vue.volar
        graphql.vscode-graphql
      ];
    };
  };
}
