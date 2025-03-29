{ self, ... }:
let
  user = import ../users/octetstream.nix;
in
{
  home-manager = {
    extraSpecialArgs = { inherit self; };
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${user.username} = import ./home.nix;

    # Enables patches for home manager installed apps
    # Turns out this has to be enabled for home manager too
    sharedModules = [
      self.inputs.mac-app-util.homeManagerModules.default
    ];
  };
}
