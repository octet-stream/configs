{ ... }:
{
  imports = [
    ./oh-my-zsh.nix
    ./aliases.nix
  ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = ''
      # Preferred editor for local and remote sessions
      if [[ -n $SSH_CONNECTION ]]; then
        export EDITOR="vim"
      else
        export EDITOR="code -wr"
      fi

      # Enable fnm hook
      eval "$(fnm env --use-on-cd)"
    '';
  };
}
