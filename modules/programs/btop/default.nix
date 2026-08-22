{ ... }:
{
  flake.modules.homeManager.btop =
    { lib, ... }:
    {
      programs.btop.enable = lib.mkDefault true;
    };
}
