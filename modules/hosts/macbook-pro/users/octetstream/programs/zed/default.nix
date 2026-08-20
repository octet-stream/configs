{ self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  userModuleKey = self.lib.mkUserModuleKey hostname username;
  zedModuleKey = self.lib.mkProgramModuleKey hostname username "zed";
  mkZedModuleKey =
    moduleName:
    self.lib.mkModuleKey [
      zedModuleKey
      moduleName
    ];
in
{
  flake.modules.homeManager.${userModuleKey} =
    { config, lib, ... }:
    {
      imports = [
        self.modules.homeManager.zed-editor
        self.modules.homeManager.${mkZedModuleKey "extensions"}
        self.modules.homeManager.${mkZedModuleKey "keybindings"}
        self.modules.homeManager.${mkZedModuleKey "settings"}
        self.modules.homeManager.${mkZedModuleKey "theme"}
      ];

      home.shellAliases = lib.mkIf config.programs.zed-editor.enable {
        zed = "zeditor";
      };
    };
}
