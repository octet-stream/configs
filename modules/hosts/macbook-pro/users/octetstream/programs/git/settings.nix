{ self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  gitModuleKey = self.lib.mkProgramModuleKey hostname username "git";
  moduleKey = self.lib.mkModuleKey [
    gitModuleKey
    "settings"
  ];
in
{
  flake.modules.homeManager.${moduleKey} = {
    programs.git.settings = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
