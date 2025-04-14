{ ... }:
{
  homebrew.brews = [
    "pulumi" # This one is up-to-date, unlike in nixpkgs
    "mysql" # This was is missing from nixpkgs
  ];
}
