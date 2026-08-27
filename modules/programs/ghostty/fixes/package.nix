# Ghostty's source package only supports Linux, so use its official binary package on Darwin.
# See: https://github.com/NixOS/nixpkgs/blob/c69ae8fb8faeb3472fd11234ba55a70ac3601f9b/pkgs/by-name/gh/ghostty/package.nix#L169
{ ... }:
{
  flake.modules.homeManager.ghostty =
    { lib, pkgs, ... }:
    {
      programs.ghostty.package = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin (
        lib.mkDefault pkgs.ghostty-bin
      );
    };
}
