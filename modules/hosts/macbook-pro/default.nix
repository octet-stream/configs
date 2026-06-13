{ inputs, ... }: {
  flake.darwinConfigurations = inputs.self.lib.mkDarwinSystem "aarch64-darwin" "macbook-pro";
}
