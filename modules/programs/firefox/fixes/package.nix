{ ... }:
{
  flake.modules.homeManager.firefox =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
      cfg = config.programs.firefox.darwin;
    in
    {
      options.programs.firefox.darwin.package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.firefox-bin;
        defaultText = lib.literalExpression "pkgs.firefox-bin";
        description = "Mozilla Firefox binary package to adapt and use on Darwin.";
      };

      config = lib.mkIf isDarwin {
        # Home Manager overrides Firefox packages to inject its configuration,
        # but firefox-bin exposes an incompatible override interface. The outer
        # overridable function absorbs those arguments and keeps Mozilla's binary.
        # See: https://github.com/nix-community/home-manager/issues/6955#issuecomment-3109421819
        programs.firefox.package = lib.mkDefault (lib.makeOverridable ({ ... }: cfg.package) { });

        # Make the upstream binary use the profiles.ini managed by Home Manager.
        # See: https://github.com/booxter/home-manager/commit/dd1602e306fec366280f5953c5e1b553e3d9672a
        home.sessionVariables = {
          MOZ_LEGACY_PROFILES = "1";
          MOZ_ALLOW_DOWNGRADE = "1";
        };
      };
    };
}
