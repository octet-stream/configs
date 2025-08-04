{ ... }:
{
  imports = [
    ./aliases.nix
    ./signing.nix
  ];

  programs.git = {
    extraConfig = {
      core.editor = "code -wr";
      init.defaultBranch = "main";
    };
  };
}
