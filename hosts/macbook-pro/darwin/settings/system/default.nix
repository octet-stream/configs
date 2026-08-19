{ self, ... }:
{
  imports = [
    ./dock.nix
    ./finder.nix
  ];
  system = {
    configurationRevision = self.rev or self.dirtyRev or null;
    stateVersion = 5;

    defaults = {
      screencapture.location = "~/Pictures/Screencaps";
      loginwindow.GuestEnabled = false;

      NSGlobalDomain = {
        AppleICUForce24HourTime = true; # Force time format to 24h
        AppleInterfaceStyle = "Dark"; # Use dark theme
      };
      CustomUserPreferences = {
        NSGlobalDomain = {
          # TODO: Remove this after updating to macOS 27
          # This disables "floating sidebar" in some of the system apps
          NSSplitViewItemSidebarDefaultsToFloatingAppearance = false;

          # Undocumented application window corner radius; no confirmed hard range.
          # Community reference points: 8 ≈ Yosemite, 10 ≈ Sequoia,
          # 20 ≈ macOS 27, 26 ≈ Tahoe. Values below 10 may distort some windows.
          # IMportant: Keep the value a float.
          NSConvolutionOverride1 = 10.0;
        };
      };
    };
  };
}
