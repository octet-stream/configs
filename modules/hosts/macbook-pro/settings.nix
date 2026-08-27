{ self, ... }:
let
  username = "octetstream";
in
{
  flake.modules.darwin.macbook-pro =
    { config, ... }:
    let
      homeManagerConfig = config.home-manager.users.${username};

      application = directory: name: {
        app = "${directory}/${name}.app";
      };

      applications = directory: map (application directory);

      homeManagerApplicationsDirectory = "${homeManagerConfig.home.homeDirectory}/${homeManagerConfig.targets.darwin.copyApps.directory}";
    in
    {
      networking = {
        computerName = "Nick's Macbook Pro";
        hostName = "macbook-pro";
      };

      system = {
        configurationRevision = self.rev or self.dirtyRev or null;
        stateVersion = 5;

        defaults = {
          controlcenter.BatteryShowPercentage = true;
          finder._FXSortFoldersFirst = true;
          loginwindow.GuestEnabled = false;
          screencapture.location = "~/Pictures/Screencaps";

          dock = {
            autohide = false;
            mru-spaces = true;
            show-recents = false;

            persistent-apps =
              applications homeManagerApplicationsDirectory [
                "Firefox"
              ]
              ++ applications "/Applications" [
                "Spark"
                "Telegram"
                "Discord"
              ]
              ++ applications homeManagerApplicationsDirectory [
                "Visual Studio Code"
                "Zed"
              ]
              ++ applications "/Applications" [
                "Linear"
              ]
              ++ applications "/System/Applications" [
                "Music"
                "Photos"
                "Calendar"
                "TV"
              ]
              ++ applications homeManagerApplicationsDirectory [
                "Ghostty"
              ]
              ++ applications "/System/Applications" [
                "System Settings"
              ];
          };

          NSGlobalDomain = {
            AppleICUForce24HourTime = true;
            AppleInterfaceStyle = "Dark";
          };

          CustomUserPreferences.NSGlobalDomain = {
            # TODO: Remove this after updating to macOS 27.
            # This disables the floating sidebar in some system applications.
            NSSplitViewItemSidebarDefaultsToFloatingAppearance = false;

            # Undocumented application window corner radius; no confirmed hard range.
            # Community reference points: 8 ≈ Yosemite, 10 ≈ Sequoia,
            # 20 ≈ macOS 27, 26 ≈ Tahoe. Values below 10 may distort some windows.
            # Keep the value a float.
            NSConvolutionOverride1 = 10.0;
          };
        };
      };
    };
}
