{ self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  vscodeModuleKey = self.lib.mkProgramModuleKey hostname username "vscode";
  moduleKey = self.lib.mkModuleKey [
    vscodeModuleKey
    "keybindings"
  ];
in
{
  flake.modules.homeManager.${moduleKey} = {
    programs.vscode.profiles.default.keybindings = [
      {
        key = "shift+cmd+'";
        command = "editor.emmet.action.splitJoinTag";
      }
    ];
  };
}
