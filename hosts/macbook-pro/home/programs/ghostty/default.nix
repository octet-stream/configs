{ pkgs, ... }:
{
  imports = [
    ./settings.nix
  ];

  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    package = if pkgs.stdenv.isDarwin then pkgs.nur.repos.DimitarNestorov.ghostty else null;
  };
}
