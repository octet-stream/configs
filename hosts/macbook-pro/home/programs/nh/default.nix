{
  config,
  pkgs,
  pkgsUnstable,
  ...
}:
{
  programs.nh = {
    enable = true;
    package = pkgsUnstable.nh;
    flake = "${config.home.homeDirectory}/projects/configs";

    clean = {
      enable = true;
      extraArgs = "--keep 5 --keep-since 3d"; # Keep generations not older than 1 week old, but at least 5 of the last generations
    };
  };

  home.packages = with pkgs; [
    nix-output-monitor
    nvd
    pkgsUnstable.nh
  ];

  # FIXME: This can be removed once home manager supports nh v4.x
  home.sessionVariables.NH_FLAKE = config.programs.nh.flake;
}
