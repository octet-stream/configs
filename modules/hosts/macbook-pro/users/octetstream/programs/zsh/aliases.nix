{ self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  zshModuleKey = self.lib.mkProgramModuleKey hostname username "zsh";
  moduleKey = self.lib.mkModuleKey [
    zshModuleKey
    "aliases"
  ];
in
{
  flake.modules.homeManager.${moduleKey} = {
    home.shellAliases = {
      projects = "cd ~/projects";
      work = "cd ~/work";
    };
  };
}
