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
      html
      dockerfile
      biome
      vue
      astro
      graphql
      svelte
      nginx
      oxc
    ];
  };
}
