{ config, pkgs, ... }:
let
  sysDir =
    if pkgs.stdenv.hostPlatform.isDarwin then
      "${config.home.homeDirectory}/Library/Application Support"
    else
      "${config.xdg.configHome}";

  vscodeConfigDirName =
    with config.programs.vscode.package;
    {
      "vscode" = "Code";
      "vscode-insiders" = "Code - Insiders";
      "vscodium" = "VSCodium";
    }
    .${pname};

  vscodeConfigPath = "${sysDir}/${vscodeConfigDirName}/User/settings.json";

in
{
  home = {
    username = "octetstream";
    homeDirectory = "/Users/octetstream";
    stateVersion = "24.05";

    # User-specific packages not available system-wide
    packages = [ ];

    sessionVariables = { };

    sessionPath = [
      "/run/current-system/sw/bin"
      "$HOME/.nix-profile/bin"
    ];

    file = {
      # Note: To make a writable link to the original file use config.lib.file.mkOutOfStoreSymlink function and point to a _full_ path using a string instead of a _path_ type
      ${vscodeConfigPath}.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/projects/dotfiles/vscode/settings.json";
    };
  };

  programs = {
    home-manager.enable = true;
    vscode = {
      enable = true;
      extensions = with pkgs.vscode-marketplace; [
        jnoortheen.nix-ide
        ms-vscode-remote.remote-containers
        biomejs.biome
        astro-build.astro-vscode
        editorconfig.editorconfig
        sdras.night-owl
        ms-vscode.sublime-keybindings
        vue.volar
        graphql.vscode-graphql
        ms-azuretools.vscode-docker
      ];
    };
  };
}
