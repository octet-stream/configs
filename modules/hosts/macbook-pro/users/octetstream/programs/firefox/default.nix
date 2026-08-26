{ self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  userModuleKey = self.lib.mkUserModuleKey hostname username;
  firefoxModuleKey = self.lib.mkProgramModuleKey hostname username "firefox";
  mkFirefoxModuleKey =
    moduleName:
    self.lib.mkModuleKey [
      firefoxModuleKey
      moduleName
    ];
in
{
  flake.modules.homeManager.${userModuleKey} = {
    imports = [
      self.modules.homeManager.firefox
      self.modules.homeManager.${mkFirefoxModuleKey "extensions"}
      self.modules.homeManager.${mkFirefoxModuleKey "pinned"}
      self.modules.homeManager.${mkFirefoxModuleKey "search-engines"}
      self.modules.homeManager.${mkFirefoxModuleKey "settings"}
    ];
  };
}
