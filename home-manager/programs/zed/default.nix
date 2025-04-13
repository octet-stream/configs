{ pkgsUnstable, ... }:
{
  imports = [
    ./settings.nix
    ./extensions.nix
  ];

  programs.zed-editor = {
    enable = true;
    package = pkgsUnstable.zed-editor;
  };
}
