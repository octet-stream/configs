# List packages installed in system profile

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # essentials
    git
    htop

    # nix-related stuff
    nixd # LSP for Nix
    nixfmt-rfc-style

    # Note: nh is disabled because it does not support darwin-nix yet
    nh
    nix-output-monitor
    nvd
  ];
}
