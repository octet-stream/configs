{ self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  zedModuleKey = self.lib.mkProgramModuleKey hostname username "zed";
  moduleKey = self.lib.mkModuleKey [
    zedModuleKey
    "keybindings"
  ];
in
{
  flake.modules.homeManager.${moduleKey} = {
    programs.zed-editor.userKeymaps = [
      {
        context = "Workspace";
        bindings = {
          cmd-alt-o = null;
          ctrl-r = [
            "projects::OpenRecent"
            { create_new_window = false; }
          ];
        };
      }
    ];
  };
}
