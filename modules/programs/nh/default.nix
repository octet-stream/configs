{ ... }:
{
  flake.modules.homeManager.nh =
    {
      lib,
      config,
      ...
    }:
    {
      programs.nh = {
        enable = lib.mkDefault true;
        flake = lib.mkDefault "${config.home.homeDirectory}/projects/configs";
      };
    };
}
