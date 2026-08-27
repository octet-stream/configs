# Home Manager passes `programs.nh.clean.extraArgs` to launchd as a single argument.
# Define the agent explicitly to preserve argument boundaries and configure an exact schedule.
#
# See: https://github.com/nix-community/home-manager/blob/09ae1b85a6db412d841d60f924b23f881f0d0a38/modules/programs/nh.nix#L152-L161
{ self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  nhModuleKey = self.lib.mkProgramModuleKey hostname username "nh";
  moduleKey = self.lib.mkModuleKey [
    nhModuleKey
    "fixes"
    "schedule-cleanup"
  ];
in
{
  flake.modules.homeManager.${moduleKey} =
    { config, lib, ... }:
    lib.mkIf config.programs.nh.enable {
      launchd.agents.nh-clean = {
        enable = true;

        config = {
          ProgramArguments = [
            (lib.getExe config.programs.nh.package)
            "clean"
            "user"
            "--keep"
            "5"
            "--keep-since"
            "3d"
          ];

          StartCalendarInterval = [
            {
              Weekday = 5;
              Hour = 21;
              Minute = 0;
            }
          ];
        };
      };
    };
}
