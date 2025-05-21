{ pkgs, ... }:
{
  programs.zed-editor-extensions = {
    enable = true;
    packages = with pkgs.zed-extensions; [
      nix
      html
      dockerfile
      biome
      halcyon
      vue
      astro
      graphql
      svelte
      nginx
    ];
  };
}
