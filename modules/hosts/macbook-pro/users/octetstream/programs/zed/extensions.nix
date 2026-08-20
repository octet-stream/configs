{ self, ... }:
let
  hostname = "macbook-pro";
  username = "octetstream";
  zedModuleKey = self.lib.mkProgramModuleKey hostname username "zed";
  moduleKey = self.lib.mkModuleKey [
    zedModuleKey
    "extensions"
  ];
in
{
  flake.modules.homeManager.${moduleKey} =
    { pkgs, ... }:
    {
      programs.zed-editor-extensions.packages = with pkgs.zed-extensions; [
        nix
        dockerfile
        biome
        vue
        astro
        graphql
        svelte
        nginx
        oxc
        prisma
        zig
        emmet
        make
        sql
        log
        scss
        proto
        caddyfile
        tsgo
      ];
    };
}
