{ inputs, ... }: {
  imports = [
    # Import this module so flake-parts can recognise generic modules
    # See: https://flake.parts/options/flake-parts-modules.html#installation
    inputs.flake-parts.flakeModules.modules
  ];
}
