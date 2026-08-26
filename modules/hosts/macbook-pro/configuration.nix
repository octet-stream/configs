{ self, ... }:
{
  flake.modules.darwin.macbook-pro =
    { pkgsUnstable, ... }:
    {
      imports = [
        self.modules.darwin.home-manager
        self.modules.darwin.docker
        self.modules.darwin.firefox
        self.modules.darwin.vscode
        self.modules.darwin.zed-editor
        self.modules.darwin.zsh
      ];

      home-manager = {
        backupFileExtension = "backup";
        extraSpecialArgs = { inherit pkgsUnstable; };
        useGlobalPkgs = true;
        useUserPackages = true;
      };

      networking.hostName = "macbook-pro";
      system = {
        primaryUser = "octetstream";
        stateVersion = 5;
      };

      virtualisation.docker = {
        enable = true;
        backend = "orbstack";
      };
    };
}
