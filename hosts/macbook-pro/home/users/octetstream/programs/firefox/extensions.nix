{ pkgs, ... }:
{
  programs.firefox.profiles.default = {
    # Auto-enable extensions managed by Home Manager
    settings = {
      "extensions.update.enabled" = false;
      "extensions.autoDisableScopes" = 0;
    };

    # List of extensions managed by Home Manager
    extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
      ublock-origin
      wappalyzer
      onepassword-password-manager

      # js frameworks & ui libraries devtools
      react-devtools
      vue-js-devtools
      reduxdevtools
    ];
  };
}
