{ self, ... }:
let
  username = "octetstream";
  userModule = "hosts/macbook-pro/users/${username}";
  zedModule = "${userModule}/zed";
in
{
  flake.modules.homeManager.${userModule} =
    { config, lib, ... }:
    {
      imports = [
        self.modules.homeManager.zed-editor
        self.modules.homeManager."${zedModule}/extensions"
        self.modules.homeManager."${zedModule}/keybindings"
        self.modules.homeManager."${zedModule}/settings"
        self.modules.homeManager."${zedModule}/theme"
      ];

      home.shellAliases = lib.mkIf config.programs.zed-editor.enable {
        zed = "zeditor";
      };
    };
}
