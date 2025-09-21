let
  mkHomeDirectory =
    { platform, username }: "/${if platform == "darwin" then "Users" else "home"}/${username}";

  mkUser =
    { username, platform }:
    let
      user = { inherit username platform; };
    in
    user // { homeDirectory = mkHomeDirectory user; };

  users.octetstream = mkUser {
    username = "octetstream";
    platform = "darwin";
  };
in
{

  users.users.octetstream.home = users.octetstream.homeDirectory;

  home-manager = {
    extraSpecialArgs = { inherit users; };
    users.octetstream = import ./octetstream;
  };

  system.primaryUser = "octetstream";
}
