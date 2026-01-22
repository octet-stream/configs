{
  pkgs ? import <nixpkgs> { },
}:
with pkgs;
mkShell {
  packages = [
    nixd
    nixfmt-rfc-style
    nodejs_24
    corepack_24
  ];
}
