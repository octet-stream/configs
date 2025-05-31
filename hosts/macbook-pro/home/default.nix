{
  self,
  inputs,
  pkgsUnstable,
  ...
}:
{
  imports = [ ./users ];

  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = { inherit self pkgsUnstable inputs; };
    sharedModules = with self.inputs; [
      mac-app-util.homeManagerModules.default # Provides fix for HM symlinked apps on macOS, so that Spotlight can find them
    ];
  };
}
