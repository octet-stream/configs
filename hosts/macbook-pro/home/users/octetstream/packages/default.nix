# List of user-specific packages

{
  pkgsUnstable,
  pkgs,
  ...
}:
let
  stablePackages = with pkgs; [
    vim
    fnm
    bun
    deno
    rustup
    docker
    ookla-speedtest
    git-extras
    nginx-language-server
    yt-dlp
    devenv

    # For work
    # infisical
    nodePackages.vercel

    # vlc package does not seeem to support macOS, but there's vlc-bin, which is macOS only -_-
    (if pkgs.stdenv.isDarwin then vlc-bin else vlc)
  ];

  unstablePackages = with pkgsUnstable; [
    pulumi-bin
    stripe-cli
  ];
in
{
  home.packages = stablePackages ++ unstablePackages;
}
