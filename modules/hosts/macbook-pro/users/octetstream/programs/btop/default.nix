{ self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  userModuleKey = self.lib.mkUserModuleKey hostname username;
  btopModuleKey = self.lib.mkProgramModuleKey hostname username "btop";
  themeModuleKey = self.lib.mkModuleKey [
    btopModuleKey
    "theme"
  ];
in
{
  flake.modules.homeManager.${userModuleKey} = {
    imports = [
      self.modules.homeManager.btop
      self.modules.homeManager.${themeModuleKey}
    ];
  };
}
