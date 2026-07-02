{ inputs, ... }: {
  flake.modules.homeManager.zed-editor = { pkgsUnstable, ... }: {
    # Adds ex-extensions overlat to `pkgs`
    imports = with inputs; [ zed-extensions.overlays.default ];

    programs.zed-editor = {
      enable = true;
      package = pkgsUnstable.zed-editor;

      # Disable auto-updates because Zed is managed by Nix
      userSettings.auto_update = false;
    };

    # Enable extension managed by zed-editor-extension module, so they can be installed using Nix
    programs.zed-editor-extensions.enable = true;
  };
}
