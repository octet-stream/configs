{
  flake.modules.darwin.macbook-pro = { pkgs, ... }: {
    users.users.octetstream = {
      shell = pkgs.zsh;
    };

    home-manager.users.octetstream = { ... }: {
      home.username = "octetstream";
    };

    programs.zsh.enable = true;
  };
}
