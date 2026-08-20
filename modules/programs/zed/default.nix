{ inputs, ... }:
let
  extensionsOverlay = {
    nixpkgs.overlays = [ inputs.zed-extensions.overlays.default ];
  };
in
{
  # Makes Zed extensions available under `pkgs.zed-extensions`.
  flake.modules.darwin.zed-editor = extensionsOverlay;
  flake.modules.nixos.zed-editor = extensionsOverlay;

  flake.modules.homeManager.zed-editor =
    {
      config,
      lib,
      pkgsUnstable,
      ...
    }:
    {
      imports = [ inputs.zed-extensions.homeManagerModules.default ];

      programs.zed-editor = {
        enable = lib.mkDefault true;
        package = lib.mkDefault pkgsUnstable.zed-editor;

        # Disable auto-updates because Zed is managed by Nix.
        userSettings.auto_update = false;
      };

      # Allow extensions to be installed declaratively from `pkgs.zed-extensions`.
      programs.zed-editor-extensions.enable = lib.mkDefault config.programs.zed-editor.enable;
    };
}
