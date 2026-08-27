{ self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  userModuleKey = self.lib.mkUserModuleKey hostname username;
  sshModuleKey = self.lib.mkProgramModuleKey hostname username "ssh";
  mkSshModuleKey =
    moduleName:
    self.lib.mkModuleKey [
      sshModuleKey
      moduleName
    ];
in
{
  flake.modules.homeManager.${userModuleKey} = {
    imports = [
      self.modules.homeManager.ssh
      self.modules.homeManager.${mkSshModuleKey "hosts"}
    ];
  };
}
