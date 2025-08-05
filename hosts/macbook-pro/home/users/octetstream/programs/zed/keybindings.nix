{ ... }:
{
  programs.zed-editor.userKeymaps = [
    {
      context = "Workspace";
      bindings = {
        # Open recent
        cmd-alt-o = null;
        ctrl-r = [
          "projects::OpenRecent"

          {
            create_new_window = false;
          }
        ];
      };
    }
  ];
}
