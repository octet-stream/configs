{ self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  sshModuleKey = self.lib.mkProgramModuleKey hostname username "ssh";
  moduleKey = self.lib.mkModuleKey [
    sshModuleKey
    "hosts"
  ];
in
{
  flake.modules.homeManager.${moduleKey} =
    { config, ... }:
    let
      inherit (config.home) homeDirectory;
    in
    {
      programs.ssh = {
        includes = [ "${homeDirectory}/.orbstack/ssh/config" ];

        settings = {
          "github.com" = {
            HostName = "github.com";
            User = "git";
            AddKeysToAgent = "yes";
            UseKeychain = "yes";
            IdentityFile = "${homeDirectory}/.ssh/id_gh_k";
          };

          everfree-deploy = {
            HostName = "octetstream.dev";
            User = "everfree";
            AddKeysToAgent = "yes";
            UseKeychain = "yes";
            IdentityFile = "${homeDirectory}/.ssh/id_everfree";
          };

          everfree-gabby = {
            HostName = "octetstream.dev";
            User = "gabby";
            AddKeysToAgent = "yes";
            UseKeychain = "yes";
            IdentityFile = "${homeDirectory}/.ssh/id_everfree_gabby";
          };

          everfree-server = {
            HostName = "octetstream.dev";
            User = "debian";
            AddKeysToAgent = "yes";
            UseKeychain = "yes";
            IdentityFile = "${homeDirectory}/.ssh/id_gandi_everfree";
            ServerAliveInterval = 60;
          };
        };
      };
    };
}
