{ pkgsUnstable, ... }:
{
  imports = [
    ./extensions.nix
    ./settings.nix
    ./theme.nix
  ];

  programs.zed-editor = {
    enable = true;
    package = pkgsUnstable.zed-editor;
  };
}
