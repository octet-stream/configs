{ ... }:
{
  imports = [
    ./settings.nix
    ./extensions.nix
  ];

  programs.zed-editor = {
    enable = true;
  };
}
