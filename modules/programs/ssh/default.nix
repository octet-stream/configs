{ ... }:
{
  flake.modules.homeManager.ssh =
    { lib, ... }:
    {
      programs.ssh = {
        enable = lib.mkDefault true;
        enableDefaultConfig = lib.mkDefault false;
        package = lib.mkDefault null;
      };
    };
}
