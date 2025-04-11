# List of user-specific packages

{
  pkgsUnstable,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    vim
    fnm # Node.js version manager written in Rust
    bun
    deno
    rustup
    ookla-speedtest
    postgresql
    git-extras
    pkgsUnstable.devenv
  ];
}
