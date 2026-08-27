{ self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  userModuleKey = self.lib.mkUserModuleKey hostname username;
  zshModuleKey = self.lib.mkProgramModuleKey hostname username "zsh";
  mkZshModuleKey =
    moduleName:
    self.lib.mkModuleKey [
      zshModuleKey
      moduleName
    ];
in
{
  flake.modules.homeManager.${userModuleKey} = {
    imports = [
      self.modules.homeManager.zsh
      self.modules.homeManager.${mkZshModuleKey "aliases"}
      self.modules.homeManager.${mkZshModuleKey "init"}
    ];
  };
}
