{ self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  gitModuleKey = self.lib.mkProgramModuleKey hostname username "git";
  moduleKey = self.lib.mkModuleKey [
    gitModuleKey
    "signing"
  ];
in
{
  flake.modules.homeManager.${moduleKey} =
    { config, ... }:
    {
      programs.git = {
        settings.user = {
          email = "nick.kruchinin@gmail.com";
          name = "Nick K.";
        };

        signing = {
          format = "ssh";
          signByDefault = true;
          key = "${config.home.homeDirectory}/.ssh/id_gh_k.pub";
        };
      };
    };
}
