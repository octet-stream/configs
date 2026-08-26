{ inputs, ... }:
{
  flake.modules.darwin.firefox = {
    nixpkgs.overlays = [
      inputs.nixpkgs-firefox-darwin.overlay
      inputs.nur.overlays.default
    ];
  };

  flake.modules.nixos.firefox = {
    nixpkgs.overlays = [ inputs.nur.overlays.default ];
  };

  flake.modules.homeManager.firefox =
    { lib, ... }:
    {
      programs.firefox = {
        enable = lib.mkDefault true;

        # Firefox is updated through Nix, not by its built-in updater.
        policies = {
          DisableAppUpdate = true;
          AppAutoUpdate = false;
          BackgroundAppUpdate = false;
          ManualAppUpdateOnly = true;
        };
      };
    };
}
