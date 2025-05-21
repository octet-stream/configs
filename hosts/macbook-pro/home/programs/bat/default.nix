{ ... }:
{
  imports = [
    ./settings.nix
    ./theme.nix
  ];

  programs.bat = {
    enable = true;
  };
}
