{ ... }:
{
  flake.modules.homeManager.bat =
    { lib, ... }:
    {
      programs.bat.enable = lib.mkDefault true;
    };
}
