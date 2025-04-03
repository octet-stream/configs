{ self, ... }:
let
  inherit (self.users.octetstream) username;
in
{
  programs.firefox.profiles.${username} = {
    id = 0;
    isDefault = true;
    settings = {
      "extensions.autoDisableScopes" = 0;
    };
  };
}
