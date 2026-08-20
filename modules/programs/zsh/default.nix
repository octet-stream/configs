{ ... }:
let
  systemModule =
    { lib, ... }:
    {
      programs.zsh.enable = lib.mkDefault true;
    };
in
{
  flake.modules.darwin.zsh = systemModule;
  flake.modules.nixos.zsh = systemModule;

  flake.modules.homeManager.zsh =
    { lib, ... }:
    {
      programs.zsh = {
        enable = lib.mkDefault true;
        enableCompletion = lib.mkDefault true;
        autosuggestion.enable = lib.mkDefault true;
        syntaxHighlighting.enable = lib.mkDefault true;
      };
    };
}
