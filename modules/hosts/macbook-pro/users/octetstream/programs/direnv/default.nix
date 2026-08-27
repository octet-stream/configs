{ self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  userModuleKey = self.lib.mkUserModuleKey hostname username;
in
{
  flake.modules.homeManager.${userModuleKey} =
    { pkgs, ... }:
    {
      imports = [ self.modules.homeManager.direnv ];

      programs.direnv.package = pkgs.direnv.overrideAttrs (_: {
        # See: https://github.com/NixOS/nixpkgs/issues/507531
        doCheck = false;
      });
    };
}
