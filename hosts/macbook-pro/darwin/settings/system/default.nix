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
        };
      };
    };
  };
}
