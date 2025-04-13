{ ... }:
let
  user = import ../../../users/octetstream.nix;

  prependAppsPath = builtins.map (name: /Applications/${name});

  prependSystemAppsPath = builtins.map (name: /System/Applications/${name});

  preprendHomeManagerAppsPath = builtins.map (
    name: "${user.homeDirectory}/Applications/Home Manager Apps/${name}"
  );
in
{
  system.defaults.dock = {
    autohide = false; # always display dock
    mru-spaces = true; # enable virtual desktop rearrangement based on recent apps use
    show-recents = false; # do not show recently closed apps

    # List of pinned applications
    persistent-apps =
      [ ]

      ++ preprendHomeManagerAppsPath [ "Firefox.app" ]

      ++ prependAppsPath [
        "Google Chrome.app"
        "Spark.app"
        "Telegram.app"
        "Discord.app"
      ]

      ++ preprendHomeManagerAppsPath [
        "Visual Studio Code.app"
        "Zed.app"
      ]

      ++ prependSystemAppsPath [
        "Music.app"
        "Photos.app"
        "Calendar.app"
        "TV.app"
      ]

      ++ prependAppsPath [ "iTerm.app" ]
      ++ prependSystemAppsPath [ "System Settings.app" ];
  };
}
