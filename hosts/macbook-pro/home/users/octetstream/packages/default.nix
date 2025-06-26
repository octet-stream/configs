# List of user-specific packages

{
  pkgsUnstable,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    vim
    fnm
    bun
    deno
    rustup
    docker
    ookla-speedtest
    postgresql
    git-extras
    nginx-language-server
    devenv

    # Unstable branch
    pkgsUnstable.pulumi-bin

    # vlc package does not seeem to support macOS, but there's vlc-bin, which is macOS only -_-
    (if pkgs.stdenv.isDarwin then vlc-bin else vlc)
  ];
}
