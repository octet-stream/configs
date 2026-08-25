{ ... }:
{
  flake.modules.darwin.docker =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.virtualisation.docker;
    in
    {
      options.virtualisation.docker = {
        enable = lib.mkEnableOption "Docker";

        package = lib.mkPackageOption pkgs "docker" { };

        backend = lib.mkOption {
          type = lib.types.nullOr (
            lib.types.enum [
              "orbstack"
              "docker-desktop"
            ]
          );
          default = null;
          description = ''
            Docker backend to install with Homebrew. When null, only the
            Docker CLI is installed. Defaults to `null`.
          '';
        };
      };

      config = lib.mkIf cfg.enable {
        assertions = [
          {
            assertion = cfg.backend == null || config.homebrew.enable;
            message = ''
              virtualisation.docker.backend requires Homebrew to be enabled.
              Import the Homebrew module or set virtualisation.docker.backend = null.
            '';
          }
        ];

        environment.systemPackages = [ cfg.package ];
        homebrew.casks = lib.optional (cfg.backend != null) cfg.backend;
      };
    };
}
