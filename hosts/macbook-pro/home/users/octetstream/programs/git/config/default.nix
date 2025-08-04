{ ... }:
{
  imports = [
    ./aliases.nix
    ./signing.nix
  ];

  programs.git = {
    extraConfig = {
      core.editor = "code -wr";
    };
  };
}
