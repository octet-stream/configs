{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = with inputs; [
    # Enables zed extensions module for Home Manager
    zed-extensions.homeManagerModules.default

    ./extensions.nix
    ./keybindings.nix
    ./settings.nix
    ./theme.nix
  ];

  programs.zed-editor.enable = true;

  home.shellAliases = lib.mkIf config.programs.zed-editor.enable {
    zed = "zeditor";
  };
}
