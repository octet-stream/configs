{
  flake.modules.darwin.macbook-pro =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        nixd
        nixfmt
        nix-init
        nurl
      ];
    };
}
