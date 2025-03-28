{ config, ... }:
{
  programs.nh = {
    enable = true;
    flake = "${config.home.homeDirectory}/projects/configs";

    clean = {
      enable = true;
      extraArgs = "-k 5 -K 1w"; # Keep generations not older than 1 week old, but at least 5 of the last generations
    };
  };
}
