{ self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  batModuleKey = self.lib.mkProgramModuleKey hostname username "bat";
  moduleKey = self.lib.mkModuleKey [
    batModuleKey
    "settings"
  ];
in
{
  flake.modules.homeManager.${moduleKey} = {
    programs.bat.config = { };
  };
}
