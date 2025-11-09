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
    infisical
    nodePackages.vercel

    # vlc package does not seeem to support macOS, but there's vlc-bin, which is macOS only -_-
    (if pkgs.stdenv.isDarwin then vlc-bin else vlc)
  ];

  unstablePackages = with pkgsUnstable; [
    pulumi-bin
    stripe-cli
    devenv # ! Wait until the release and move devenv back to stable channel: https://github.com/NixOS/nixpkgs/pull/459771
  ];
in
{
  home.packages = stablePackages ++ unstablePackages;
}
