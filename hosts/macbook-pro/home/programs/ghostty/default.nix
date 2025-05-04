{ ... }:
{
  imports = [
    ./fixes
    ./settings.nix
  ];

  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
  };
}
