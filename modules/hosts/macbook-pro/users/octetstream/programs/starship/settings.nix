{ self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  starshipModuleKey = self.lib.mkProgramModuleKey hostname username "starship";
  moduleKey = self.lib.mkModuleKey [
    starshipModuleKey
    "settings"
  ];
in
{
  flake.modules.homeManager.${moduleKey} = {
    programs.starship.settings = {
      add_newline = false;
      command_timeout = 120000;

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
    };
  };
}
