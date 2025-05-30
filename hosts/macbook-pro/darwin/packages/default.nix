# List packages installed in system profile

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # essentials
    git # TODO: Move Git setup and configuration to Home Manager
    htop # TODO: Move this to Home Manager

    # nix-related stuff
    nixd # LSP for Nix
    nixfmt-rfc-style
  ];
}
