{ ... }:
{
  imports = [
    ./fixes
    ./settings.nix
    ./keybind.nix
  ];

  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
  };
}
