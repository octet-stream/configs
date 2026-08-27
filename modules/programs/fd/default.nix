{ ... }:
{
  flake.modules.homeManager.fd =
    { lib, ... }:
    {
      programs.fd.enable = lib.mkDefault true;
    };
}
