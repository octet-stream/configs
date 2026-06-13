# Default devShell entry point (flake).
#
# Basically it just imports `shell.nix` file from project's root where the shell itself defined

{ self, ... }: {
  perSystem = { pkgs, ... }: {
    devShells.default = import (self + /shell.nix) { inherit pkgs; };
  };
}
