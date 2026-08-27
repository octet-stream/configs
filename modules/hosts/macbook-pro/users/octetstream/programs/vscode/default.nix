{ self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  userModuleKey = self.lib.mkUserModuleKey hostname username;
  vscodeModuleKey = self.lib.mkProgramModuleKey hostname username "vscode";
  mkVscodeModuleKey =
    moduleName:
    self.lib.mkModuleKey [
      vscodeModuleKey
      moduleName
    ];
in
{
  flake.modules.homeManager.${userModuleKey} = {
    imports = [
      self.modules.homeManager.vscode
      self.modules.homeManager.${mkVscodeModuleKey "extensions"}
      self.modules.homeManager.${mkVscodeModuleKey "keybindings"}
      self.modules.homeManager.${mkVscodeModuleKey "settings"}
      self.modules.homeManager.${mkVscodeModuleKey "theme"}
    ];
  };
}
