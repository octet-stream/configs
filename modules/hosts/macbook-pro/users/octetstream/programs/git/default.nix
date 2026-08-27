{ self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  userModuleKey = self.lib.mkUserModuleKey hostname username;
  gitModuleKey = self.lib.mkProgramModuleKey hostname username "git";
  mkGitModuleKey =
    moduleName:
    self.lib.mkModuleKey [
      gitModuleKey
      moduleName
    ];
in
{
  flake.modules.homeManager.${userModuleKey} = {
    imports = [
      self.modules.homeManager.git
      self.modules.homeManager.${mkGitModuleKey "aliases"}
      self.modules.homeManager.${mkGitModuleKey "settings"}
      self.modules.homeManager.${mkGitModuleKey "signing"}
    ];
  };
}
