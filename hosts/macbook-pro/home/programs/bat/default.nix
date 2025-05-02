{ ... }:
{
  imports = [
    ./settings.nix
  ];

  programs.bat = {
    enable = true;
  };
}
