{
  self,
  pkgs,
  ...
}:
let
  user = import ../users/octetstream.nix;

  prependAppsPath = builtins.map (name: /Applications/${name});

  prependSystemAppsPath = builtins.map (name: /System/Applications/${name});

  preprendHomeManagerAppsPath = builtins.map (
    name: "${user.homeDirectory}/Applications/Home Manager Apps/${name}"
  );
in
{
  imports = [ ./homebrew ];

  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = "aarch64-darwin";

    overlays = [
      self.inputs.nix-vscode-extensions.overlays.default
      self.inputs.nix4vscode.overlays.forVscode
      self.inputs.nh.overlays.default
    ];
  };

  users.users.${user.username}.home = user.homeDirectory;

  networking = {
    computerName = "Nick's Macbook Pro";
    hostName = "macbook-pro";
  };

  # Auto upgrade nix package and the daemon service using version from this package.
  nix.package = pkgs.nixVersions.latest;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Enable Touch ID auth authentication for sudo
  # ! This is deprecated option. Replace it with the next line when 25.x branch is released
  security.pam.enableSudoTouchIdAuth = true;
  # security.pam.services.sudo_local.touchIdAuth = true;

  system = {
    configurationRevision = self.rev or self.dirtyRev or null;
    stateVersion = 5;

    defaults = {
      screencapture.location = "~/Pictures/Screencaps";
      loginwindow.GuestEnabled = false;

      dock = {
        autohide = false; # always display dock
        mru-spaces = false; # disable spaces rearrangement based on recent apps use
        show-recents = false; # do not show recently closed apps

        # List of pinned applications
        persistent-apps =
          [ ]

          ++ prependAppsPath [
            "Firefox.app"
            "Google Chrome.app"
            "Spark.app"
            "Telegram.app"
            "Discord.app"
            # "Visual Studio Code.app"
          ]

          ++ preprendHomeManagerAppsPath [ "Visual Studio Code.app" ]

          ++ prependSystemAppsPath [
            "Music.app"
            "Photos.app"
            "Calendar.app"
            "TV.app"
          ]

          ++ prependAppsPath [ "iTerm.app" ]
          ++ prependSystemAppsPath [ "System Settings.app" ];
      };

      NSGlobalDomain = {
        AppleICUForce24HourTime = true; # Force time format to 24h
        AppleInterfaceStyle = "Dark"; # Use dark theme
      };
    };
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # or visit https://search.nixos.org
  # TODO: Move system packages into its own module
  environment.systemPackages = with pkgs; [
    # essentials
    git
    htop

    # nix-related stuff
    nixd # LSP for Nix
    nixfmt-rfc-style

    # Note: nh is disabled because it does not support darwin-nix yet
    nh
    nix-output-monitor
    nvd
  ];
}
