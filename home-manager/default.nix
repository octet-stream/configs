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
  };
}
