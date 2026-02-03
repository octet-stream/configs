{
  config,
  pkgs,
  lib,
  ...
}:
lib.mkIf config.programs.zed-editor.enable {
  programs.zed-editor-extensions = {
    enable = true;
    packages = with pkgs.zed-extensions; [
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
      ruby
      dart
      log
      scss
      proto
      caddyfile
      tsgo
    ];
  };
}
