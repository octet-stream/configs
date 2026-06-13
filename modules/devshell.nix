# Default devShell entry point (flake).
#
# Basically it just imports `shell.nix` file from project's root where the shell itself defined

{ inputs, ... }: {
  perSystem = { pkgs, ... }: {
    devShells.default = import (inputs.self + /shell.nix) { inherit pkgs; };
  };
}
