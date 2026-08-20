{ self, ... }:
{
  flake.modules.darwin.macbook-pro =
    {
      pkgs,
      utils,
      ...
    }:
    let
      username = "octetstream";
      homeDirectory = utils.mkHomeDirectory username;
    in
    {
      imports = [ self.modules.generic.utils ];

      users.users.${username} = {
        home = homeDirectory;
        shell = pkgs.zsh;
      };

      home-manager.users.${username} = { ... }: {
        home = {
          inherit username homeDirectory;
          stateVersion = "24.11";
        };
      };

      programs.zsh.enable = true;
    };
}
