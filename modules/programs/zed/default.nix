{ inputs, ... }: {
  flake.modules.homeManager.zed-editor = { pkgsUnstable, lib, ... }: {
    # Adds ex-extensions overlat to `pkgs`
    imports = with inputs; [ zed-extensions.overlays.default ];

    programs.zed-editor = {
      enable = lib.mkDefault true;
      package = lib.mkDefault pkgsUnstable.zed-editor;

      # Disable auto-updates because Zed is managed by Nix
      userSettings.auto_update = false;
    };

    # Enable extension managed by zed-editor-extension module, so they can be installed using Nix
    programs.zed-editor-extensions.enable = lib.mkDefault true;
  };
}
