{ ... }:
{
  imports = [
    ./extensions.nix
    ./settings.nix
  ];

  programs.firefox = {
    enable = true;
  };
}
