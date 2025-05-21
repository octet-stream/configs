{
  self,
  pkgsUnstable,
  ...
}:
{
  home-manager = {
    extraSpecialArgs = { inherit self pkgsUnstable; };
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${self.users.octetstream.username} = import ./home.nix;

    sharedModules = with self.inputs; [
      # Enables patches for home manager installed apps
      # Turns out this has to be enabled for home manager too
      mac-app-util.homeManagerModules.default

      # Adds zed-extensions to programs attrset
      zed-extensions.homeManagerModules.default

      catppuccin.homeModules.catppuccin
    ];
  };
}
