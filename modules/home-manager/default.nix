{ inputs, self, ... }:
{
  flake.modules.homeManager.darwin =
    { lib, ... }:
    {
      targets.darwin = {
        linkApps.enable = lib.mkDefault false;
        copyApps = {
          enable = lib.mkDefault true;
          enableChecks = lib.mkDefault true;
        };
      };
    };

  flake.modules.darwin.home-manager = {
    imports = [ inputs.home-manager.darwinModules.home-manager ];
    home-manager.sharedModules = [ self.modules.homeManager.darwin ];
  };
}
