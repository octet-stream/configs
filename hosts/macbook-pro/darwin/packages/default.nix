# List packages installed in system profile

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # essentials
    htop # TODO: Move this to Home Manager

    # nix-related stuff
    nixd # LSP for Nix
    nixfmt-rfc-style
    nix-init
    nurl
  ];
}
