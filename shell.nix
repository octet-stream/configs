{
  pkgs ? import <nixpkgs>,
}:
with pkgs;
mkShell {
  nativeBuildInputs = [
    nixd
    nixfmt-rfc-style
    bash-language-server

    # Corepack is broken prior v0.31.x, so use Node.js v23 for now, which includes it
    nodejs_23
    corepack_23
  ];
}
