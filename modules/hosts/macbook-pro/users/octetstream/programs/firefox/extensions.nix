{ self, ... }:
let
  moduleKey = self.lib.mkModuleKey [
    (self.lib.mkProgramModuleKey "macbook-pro" "octetstream" "firefox")
    "extensions"
  ];
in
{
  flake.modules.homeManager.${moduleKey} =
    { pkgs, ... }:
    {
      programs.firefox.profiles.default = {
        settings = {
          "extensions.update.enabled" = false;
          "extensions.autoDisableScopes" = 0;
        };

        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          wappalyzer
          onepassword-password-manager
          react-devtools
          vue-js-devtools
          reduxdevtools
        ];
      };
    };
}
