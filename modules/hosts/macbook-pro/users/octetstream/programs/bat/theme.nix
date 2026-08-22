{ self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  batModuleKey = self.lib.mkProgramModuleKey hostname username "bat";
  moduleKey = self.lib.mkModuleKey [
    batModuleKey
    "theme"
  ];
in
{
  flake.modules.homeManager.${moduleKey} =
    { config, lib, ... }:
    lib.mkIf config.programs.bat.enable {
      catppuccin.bat.enable = true;
    };
}
