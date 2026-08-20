{ inputs, self, ... }:
{
  flake.modules.darwin.macbook-pro =
    { pkgsUnstable, ... }:
    {
      imports = [
        inputs.home-manager.darwinModules.home-manager
        self.modules.darwin.homebrew
        self.modules.darwin.vscode
        self.modules.darwin.zed-editor
        self.modules.darwin.zsh
      ];

      nix-homebrew.enableRosetta = true;

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
    };
}
