{
  imports = [
    ./fixes
    ./settings.nix
    ./keybind.nix
    ./theme.nix
  ];

  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
  };
}
