{
  imports = [
    ./aliases.nix
    ./signing.nix
  ];

  programs.git.settings = {
    core.editor = "code -wr";
    init.defaultBranch = "main";
    pull.rebase = true;
  };
}
