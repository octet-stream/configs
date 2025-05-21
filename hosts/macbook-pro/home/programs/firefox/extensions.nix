{ self, pkgs, ... }:
let
  inherit (self.users.octetstream) username;
  inherit (pkgs.nur.repos.rycee) firefox-addons;
in
{
  programs.firefox.profiles.${username}.extensions.packages = with firefox-addons; [
    ublock-origin
    wappalyzer
    onepassword-password-manager

    # js frameworks & ui libraries devtools
    react-devtools
    vue-js-devtools
    reduxdevtools
  ];
}
