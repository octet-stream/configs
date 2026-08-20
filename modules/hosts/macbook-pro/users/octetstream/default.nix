{ self, ... }:
let
  username = "octetstream";
  userModule = "hosts/macbook-pro/users/${username}";
in
{
  flake.modules.homeManager.${userModule} = {
    imports = [ self.modules.generic.utils ];

    home.stateVersion = "24.11";
    programs.home-manager.enable = true;
  };

  flake.modules.darwin.macbook-pro =
    {
      pkgs,
      utils,
      ...
    }:
    let
      homeDirectory = utils.mkHomeDirectory username;
    in
    {
      imports = [ self.modules.generic.utils ];

      users.users.${username} = {
        home = homeDirectory;
        shell = pkgs.zsh;
      };

      home-manager.users.${username} = { ... }: {
        imports = [ self.modules.homeManager.${userModule} ];

        home = {
          inherit username homeDirectory;
        };
      };

      programs.zsh.enable = true;
    };
}
