# List packages installed in system profile

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # nix-related stuff
    nixd # LSP for Nix
    nixfmt-rfc-style
    nix-init
    nurl
  ];
}
