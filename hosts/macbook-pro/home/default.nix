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
      # Enables patches for home manager installed apps
      # Turns out this has to be enabled for home manager too
      mac-app-util.homeManagerModules.default
    ];
  };
}
