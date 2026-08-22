{ self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  userModuleKey = self.lib.mkUserModuleKey hostname username;
  nhModuleKey = self.lib.mkProgramModuleKey hostname username "nh";
  scheduleCleanupModuleKey = self.lib.mkModuleKey [
    nhModuleKey
    "fixes"
    "schedule-cleanup"
  ];
in
{
  flake.modules.homeManager.${userModuleKey} =
    { pkgsUnstable, ... }:
    {
      imports = [
        self.modules.homeManager.nh
        self.modules.homeManager.${scheduleCleanupModuleKey}
      ];

      programs.nh.package = pkgsUnstable.nh;
    };
}
