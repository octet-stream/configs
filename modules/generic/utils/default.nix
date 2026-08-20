{ ... }:
{
  flake.modules.generic.utils =
    { pkgs, ... }:
    let
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
        inherit mkHomeDirectory;
      };
    };
}
