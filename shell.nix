{
  pkgs ? import <nixpkgs> { },
}:
with pkgs;
mkShell {
  packages = [
    nixd
    nixfmt-rfc-style
    bash-language-server
    nodejs_22
    corepack_22
  ];
}
