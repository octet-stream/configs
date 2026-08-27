{ self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  userModuleKey = self.lib.mkUserModuleKey hostname username;
  ghosttyModuleKey = self.lib.mkProgramModuleKey hostname username "ghostty";
  mkGhosttyModuleKey =
    moduleName:
    self.lib.mkModuleKey [
      ghosttyModuleKey
      moduleName
    ];
in
{
  flake.modules.homeManager.${userModuleKey} = {
    imports = [
      self.modules.homeManager.ghostty
      self.modules.homeManager.${mkGhosttyModuleKey "keybindings"}
      self.modules.homeManager.${mkGhosttyModuleKey "settings"}
      self.modules.homeManager.${mkGhosttyModuleKey "theme"}
    ];
  };
}
