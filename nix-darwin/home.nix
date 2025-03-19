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
      ${vscodeConfigPath}.source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/projects/dotfiles/vscode/settings.json";
    };
  };

  programs = {
    home-manager.enable = true;
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "git"
          "fnm"
        ];
      };
      initExtra = ''
        # Preferred editor for local and remote sessions
        if [[ -n $SSH_CONNECTION ]]; then
          export EDITOR="vim"
        else
          export EDITOR="code -wr"
        fi

        # Enable fnm hook
        eval "$(fnm env --use-on-cd)"
      '';
      shellAliases = {
        projects = "cd ~/projects";
        work = "cd ~/work";
        gpom = "git push origin main";
        mac-rebuild = "darwin-rebuild switch --flake ~/projects/dotfiles/nix-darwin#macbook-pro";
      };
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
