{ ... }:
{
  imports = [
    ./extensions.nix
    ./pinned.nix
    ./settings.nix
  ];

  programs.firefox.enable = true;
}
