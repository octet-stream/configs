{ pkgsUnstable, ... }:
{
  config = {
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
      package = pkgsUnstable.direnv;
    };
  };
}
