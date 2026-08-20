{ self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  zshModuleKey = self.lib.mkProgramModuleKey hostname username "zsh";
  moduleKey = self.lib.mkModuleKey [
    zshModuleKey
    "init"
  ];
in
{
  flake.modules.homeManager.${moduleKey} =
    { lib, pkgs, ... }:
    {
      home.packages = [ pkgs.fnm ];

      programs.zsh.initContent = ''
        # Preferred editor for local and remote sessions.
        if [[ -n "$SSH_CONNECTION" ]]; then
          export EDITOR="vim"
        else
          export EDITOR="code -wr"
        fi

        eval "$(${lib.getExe pkgs.fnm} env --use-on-cd --shell zsh)"
      '';
    };
}
