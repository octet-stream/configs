{ ... }:
{
  programs.zsh.shellAliases = {
    projects = "cd ~/projects";
    work = "cd ~/work";
    gpom = "git push origin main";
    mac-rebuild = "nh darwin switch";
    mac-up = "nix flake update --flake ~/projects/configs";
  };
}
