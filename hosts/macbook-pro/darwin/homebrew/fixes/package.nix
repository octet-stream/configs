{ self, ... }:
let
  flakeLock = builtins.fromJSON (builtins.readFile (self + /flake.lock));
  brewVersion = flakeLock.nodes.homebrew.original.ref;

  # Override homebrew version so I can use latest version without waiting for nix-homebrew to catch up (on my own risk of course)
  # References:
  # https://github.com/zhaofengli/nix-homebrew/blob/53507607d69c88efc816e806b8139607c7257285/flake.nix#L17-L18
  # https://github.com/zhaofengli/nix-homebrew/blob/53507607d69c88efc816e806b8139607c7257285/flake.nix#L46-L49
  brewPackage = self.inputs.homebrew // {
    name = "brew-${brewVersion}";
    version = brewVersion;
  };
in
{
  nix-homebrew.package = brewPackage;
}
