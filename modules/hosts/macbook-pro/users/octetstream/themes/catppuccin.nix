{ inputs, self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  userModuleKey = self.lib.mkUserModuleKey hostname username;
in
{
  flake.modules.homeManager.${userModuleKey} = { pkgs, ... }: {
    imports = [ self.modules.homeManager.catppuccin ];

    catppuccin.sources.vscode =
      inputs.catppuccin.packages.${pkgs.stdenv.hostPlatform.system}.vscode.override
        {
          pnpm_10 = pkgs.pnpm_10_latest;
        };

    catppuccin = {
      flavor = "mocha";
      accent = "blue";
    };
  };
}
