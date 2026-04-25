{ pkgs, ... }:
{
  config = {
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
      package = pkgs.direnv.overrideAttrs (_: {
        doCheck = false; # disabled due to check failure, see: https://github.com/NixOS/nixpkgs/issues/507531
      });
    };
  };
}
