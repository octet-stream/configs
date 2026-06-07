{
  self,
  inputs,
  pkgsUnstable,
  ...
}:
{
  imports = [ ./users ];

  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = { inherit self pkgsUnstable inputs; };
  };
}
