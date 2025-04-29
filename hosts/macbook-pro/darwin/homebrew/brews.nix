{ ... }:
{
  homebrew.brews = [
    # "pulumi" # This one is up-to-date, unlike in nixpkgs
    "mysql" # This one is missing in nixpkgs
  ];
}
