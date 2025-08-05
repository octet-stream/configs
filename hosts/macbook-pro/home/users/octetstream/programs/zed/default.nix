{ inputs, pkgsUnstable, ... }:
{
  imports = with inputs; [
    # Enables zed extensions module for Home Manager
    zed-extensions.homeManagerModules.default

    ./extensions.nix
    ./keybindings.nix
    ./settings.nix
    ./theme.nix
  ];

  programs.zed-editor = {
    enable = true;
    package = pkgsUnstable.zed-editor;
  };
}
