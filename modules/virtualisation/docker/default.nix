{ ... }:
{
  flake.modules.homeManager.docker =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.programs.docker;
    in
    {
      options.programs.docker = {
        enable = lib.mkEnableOption "Docker CLI";
        package = lib.mkPackageOption pkgs "docker-client" { };
      };

      config = lib.mkMerge [
        {
          programs.docker.enable = lib.mkDefault true;
        }

        (lib.mkIf cfg.enable {
          home.packages = [ cfg.package ];
        })
      ];
    };

  flake.modules.nixos.docker =
    { lib, ... }:
    {
      virtualisation.docker.enable = lib.mkDefault true;
    };
}
