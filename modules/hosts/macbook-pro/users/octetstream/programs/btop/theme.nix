{ self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  btopModuleKey = self.lib.mkProgramModuleKey hostname username "btop";
  moduleKey = self.lib.mkModuleKey [
    btopModuleKey
    "theme"
  ];
in
{
  flake.modules.homeManager.${moduleKey} =
    { config, lib, ... }:
    lib.mkIf config.programs.btop.enable {
      catppuccin.btop.enable = true;
    };
}
