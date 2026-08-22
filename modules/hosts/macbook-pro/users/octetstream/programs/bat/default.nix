{ self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  userModuleKey = self.lib.mkUserModuleKey hostname username;
  batModuleKey = self.lib.mkProgramModuleKey hostname username "bat";
  mkBatModuleKey =
    moduleName:
    self.lib.mkModuleKey [
      batModuleKey
      moduleName
    ];
in
{
  flake.modules.homeManager.${userModuleKey} = {
    imports = [
      self.modules.homeManager.bat
      self.modules.homeManager.${mkBatModuleKey "settings"}
      self.modules.homeManager.${mkBatModuleKey "theme"}
    ];
  };
}
