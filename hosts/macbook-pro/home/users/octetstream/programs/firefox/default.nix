{
  imports = [
    ./fixes

    ./extensions.nix
    ./pinned.nix
    ./settings.nix
    ./policies.nix
    ./search-engines.nix
  ];

  programs.firefox.enable = true;
}
