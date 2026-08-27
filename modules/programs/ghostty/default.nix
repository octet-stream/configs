{ ... }:
{
  flake.modules.homeManager.ghostty =
    { config, lib, ... }:
    {
      programs.ghostty = {
        enable = lib.mkDefault true;
        enableZshIntegration = lib.mkDefault config.programs.zsh.enable;

        # Ghostty is updated through Nix.
        settings.auto-update = "off";
      };
    };
}
