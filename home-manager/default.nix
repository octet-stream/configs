{
  self,
  system,
  pkgsUnstable,
  ...
}:
{
  home-manager = {
    extraSpecialArgs = { inherit self system pkgsUnstable; };
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${self.users.octetstream.username} = import ./home.nix;

    # Enables patches for home manager installed apps
    # Turns out this has to be enabled for home manager too
    sharedModules = [
      self.inputs.mac-app-util.homeManagerModules.default
    ];
  };
}
