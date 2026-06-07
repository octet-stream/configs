{
  pkgs ? import <nixpkgs> { },
}:
with pkgs;
mkShell {
  packages = [
    nixd
    nixfmt
    nodejs-slim_26
    corepack
  ];

  shellHook = ''
    ${corepack}/bin/pnpm i --frozen-lockfile
  '';
}
