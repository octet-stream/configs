{ self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  userModuleKey = self.lib.mkUserModuleKey hostname username;
in
{
  flake.modules.homeManager.${userModuleKey} = {
    imports = [ self.modules.homeManager.fd ];
  };
}
