{ ... }:
{
  imports = [
    ./vscode
  ];
  home = {
    username = "octetstream";
    homeDirectory = "/Users/octetstream";
    stateVersion = "24.11";

    sessionPath = [
      "/run/current-system/sw/bin"
      "$HOME/.nix-profile/bin"
    ];
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
        mac-rebuild = "darwin-rebuild switch --flake ~/projects/configs#macbook-pro";
        mac-up = "nix flake update --flake ~/projects/configs";
      };
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
