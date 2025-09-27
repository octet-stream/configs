{
  imports = [
    ./fixes

    ./extensions.nix
    ./pinned.nix
    # ./settings.nix
    # ./search-engines.nix
  ];

  programs.firefox.enable = true;
}
