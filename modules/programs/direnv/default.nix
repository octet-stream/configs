{ ... }:
{
  flake.modules.homeManager.direnv =
    { config, lib, ... }:
    {
      programs.direnv = {
        enable = lib.mkDefault true;
        enableZshIntegration = lib.mkDefault config.programs.zsh.enable;
        nix-direnv.enable = lib.mkDefault true;
      };
    };
}
