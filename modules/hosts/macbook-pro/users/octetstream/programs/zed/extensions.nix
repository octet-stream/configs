{ ... }:
let
  username = "octetstream";
  zedModule = "hosts/macbook-pro/users/${username}/zed";
in
{
  flake.modules.homeManager."${zedModule}/extensions" =
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
