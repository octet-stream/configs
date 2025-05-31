{ pkgs, ... }:
{
  programs.firefox.profiles.default.extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
    ublock-origin
    wappalyzer
    onepassword-password-manager

    # js frameworks & ui libraries devtools
    react-devtools
    vue-js-devtools
    reduxdevtools
  ];
}
