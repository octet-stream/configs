# Homebrew installation managed by Nix

{
  nix-homebrew = {
    enable = true;
    autoMigrate = true;
    enableRosetta = true;
    user = "octetstream";
  };
}
