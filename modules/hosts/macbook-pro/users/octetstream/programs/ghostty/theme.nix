{ self, ... }:
let
  moduleKey = self.lib.mkModuleKey [
    (self.lib.mkProgramModuleKey "macbook-pro" "octetstream" "ghostty")
    "theme"
  ];
in
{
  flake.modules.homeManager.${moduleKey} =
    { config, lib, ... }:
    lib.mkIf config.programs.ghostty.enable {
      catppuccin.ghostty.enable = true;
    };
}
