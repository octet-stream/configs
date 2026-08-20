{ lib, ... }:
let
  mkModuleKey = lib.concatStringsSep "/";

  mkUserModuleKey =
    hostname: username:
    mkModuleKey [
      "hosts"
      hostname
      "users"
      username
    ];

  mkProgramModuleKey =
    hostname: username: programName:
    mkModuleKey [
      (mkUserModuleKey hostname username)
      programName
    ];
in
{
  flake.lib = {
    inherit mkModuleKey mkProgramModuleKey mkUserModuleKey;
  };

  flake.modules.generic.utils =
    { lib, pkgs, ... }:
    let
      capitalize =
        value: (lib.toUpper (lib.substring 0 1 value)) + (lib.substring 1 (lib.stringLength value) value);

      mkHomeDirectory =
        username:
        if pkgs.stdenv.hostPlatform.isDarwin then
          "/Users/${username}"
        else if pkgs.stdenv.hostPlatform.isLinux then
          "/home/${username}"
        else
          throw "Unsupported host platform: ${pkgs.stdenv.hostPlatform.system}";
    in
    {
      _module.args.utils = {
        inherit
          capitalize
          mkHomeDirectory
          mkModuleKey
          mkProgramModuleKey
          mkUserModuleKey
          ;
      };
    };
}
