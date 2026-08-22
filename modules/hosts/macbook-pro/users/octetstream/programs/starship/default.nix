{ self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  userModuleKey = self.lib.mkUserModuleKey hostname username;
  starshipModuleKey = self.lib.mkProgramModuleKey hostname username "starship";
  settingsModuleKey = self.lib.mkModuleKey [
    starshipModuleKey
    "settings"
  ];
in
{
  flake.modules.homeManager.${userModuleKey} = {
    imports = [
      self.modules.homeManager.starship
      self.modules.homeManager.${settingsModuleKey}
    ];
  };
}
