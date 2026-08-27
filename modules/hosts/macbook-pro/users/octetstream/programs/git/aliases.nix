{ self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  gitModuleKey = self.lib.mkProgramModuleKey hostname username "git";
  moduleKey = self.lib.mkModuleKey [
    gitModuleKey
    "aliases"
  ];
in
{
  flake.modules.homeManager.${moduleKey} = {
    home.shellAliases = {
      ga = "git add";
      gc = "git commit";
      gst = "git status";
      gp = "git push";
      gpom = "git push origin main";
    };

    programs.git.settings.alias = {
      sw = "switch";
      swc = "switch -c";
      ps = "push";
      bd = "branch -d";
      bdd = "branch -D";
    };
  };
}
