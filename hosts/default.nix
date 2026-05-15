{ inputs, ... }:
{
  imports = with inputs; [ easy-hosts.flakeModule ];

  easy-hosts.hosts.macbook-pro =
    let
      system = "aarch64-darwin";
      pkgsUnstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      arch = "aarch64";
      class = "darwin";
      specialArgs = { inherit pkgsUnstable inputs; };
    };
}
