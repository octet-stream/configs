{ self, ... }:
let
  moduleKey = self.lib.mkModuleKey [
    (self.lib.mkProgramModuleKey "macbook-pro" "octetstream" "ghostty")
    "keybindings"
  ];
in
{
  flake.modules.homeManager.${moduleKey} = {
    programs.ghostty.settings.keybind = [
      "global:cmd+escape=toggle_quick_terminal"
    ];
  };
}
