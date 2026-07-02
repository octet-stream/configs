{ self, ... }: {
  flake.darwinConfigurations = self.lib.mkDarwinSystem "aarch64-darwin" "macbook-pro";
}
