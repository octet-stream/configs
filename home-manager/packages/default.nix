# List of user-specific packages

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vim
    fnm # Node.js version manager written in Rust
    bun
    deno
    rustup
    ookla-speedtest
    postgresql
  ];
}
