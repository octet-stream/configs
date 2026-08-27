{ ... }:
{
  flake.modules.homeManager.git =
    { lib, ... }:
    {
      programs.git.enable = lib.mkDefault true;
    };
}
