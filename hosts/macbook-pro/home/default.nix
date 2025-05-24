{
  self,
  inputs,
  pkgsUnstable,
  ...
}:
{
  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;

    users.${self.users.octetstream.username} = import ./home.nix;

    extraSpecialArgs = { inherit self pkgsUnstable inputs; };
    sharedModules = with self.inputs; [
      mac-app-util.homeManagerModules.default # Provides fix for HM symlinked apps on macOS, so that Spotlight can find them
    ];
  };
}
