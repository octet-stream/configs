{ ... }:
{
  homebrew.brews = [
    "git-extras" # TODO: Install it from nixpkgs instead
    "pulumi" # This one is up-to-date, unlike in nixpkgs
    "mysql" # This was is missing from nixpkgs
  ];
}
