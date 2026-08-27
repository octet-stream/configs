{ ... }:
{
  flake.modules.homeManager.starship =
    { lib, ... }:
    {
      programs.starship.enable = lib.mkDefault true;
    };
}
