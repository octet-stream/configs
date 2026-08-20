{ self, ... }:
let
  username = "octetstream";
  userModule = "hosts/macbook-pro/users/${username}";
in
{
  flake.modules.homeManager.${userModule} = {
    imports = [ self.modules.homeManager.catppuccin ];

    catppuccin = {
      flavor = "mocha";
      accent = "blue";
    };
  };
}
