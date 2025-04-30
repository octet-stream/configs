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
    pkgsUnstable.pulumi-bin

    # vlc package does not seeem to support macOS, but there's vlc-bin, which is macOS only -_-
    (if pkgs.stdenv.isDarwin then vlc-bin else vlc)
  ];
}
