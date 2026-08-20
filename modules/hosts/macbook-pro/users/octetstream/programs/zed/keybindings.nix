{ ... }:
let
  username = "octetstream";
  zedModule = "hosts/macbook-pro/users/${username}/zed";
in
{
  flake.modules.homeManager."${zedModule}/keybindings" = {
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
