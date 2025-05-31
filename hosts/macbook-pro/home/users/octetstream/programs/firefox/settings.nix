{ lib, ... }:
let
  abs = x: if x < 0 then 0 - x else x;

  padTopSitesList = amount: builtins.genList (i: { url = "about:blank?${toString (i + 1)}"; }) amount;

  genTopSites =
    input:
    let
      limit = 8 * 4;
      inputLength = builtins.length input;
      rows = abs (builtins.ceil (inputLength / 8.0));
      list = input ++ padTopSitesList (8 * rows - inputLength);
      enable = (builtins.length list) > 0;
    in
    assert lib.assertMsg (inputLength <= limit)
      "The limit of pinned sites is exceeded. Expected ${toString limit}, but the list has ${toString inputLength} elements";
    {
      inherit list enable rows;
    };

  topSites = genTopSites [
    {
      label = "GitHub";
      url = "https://github.com";
    }

    {
      label = "YouTube";
      url = "https://youtube.com";
    }

    {
      label = "Derpibooru";
      url = "https://derpibooru.org";
    }

    {
      label = "Furbooru";
      url = "https://furbooru.org";
    }

    {
      label = "Bluesky";
      url = "https://bsky.app";
    }

    {
      label = "Twitter / X";
      url = "https://x.com";
    }

    {
      label = "Reddit";
      url = "https://reddit.com";
    }

    {
      label = "Noogle (nix api search)";
      url = "https://noogle.dev";
    }

    {
      label = "Docker Hub";
      url = "https://hub.docker.com";
    }

    {
      label = "TypeScript";
      url = "https://typescriptlang.org";
    }

    {
      label = "React";
      url = "https://react.dev";
    }

    {
      label = "Qwik";
      url = "https://qwik.dev";
    }

    {
      label = "Vue";
      url = "https://vuejs.org";
    }
  ];
in
{
  programs.firefox.profiles.default = {
    id = 0;
    isDefault = true;
    settings = {
      # Disable auto updates, to delegate it to Home Manager
      "app.update.auto" = false;
      "extensions.update.unabled" = false;

      # Auto-enable extensions managed by Home Manager
      "extensions.autoDisableScopes" = 0;

      # Pinned sites
      "browser.newtabpage.activity-stream.feeds.topsites" = topSites.enable;
      "browser.newtabpage.activity-stream.topSitesRows" = topSites.rows;
      "browser.newtabpage.pinned" = builtins.toJSON topSites.list; # List of pinned tabs

      # Disable irritating first-run stuff
      "browser.disableResetPrompt" = true;
      "browser.download.panel.shown" = true;
      "browser.feeds.showFirstRunUI" = false;
      "browser.messaging-system.whatsNewPanel.enabled" = false;
      "browser.rights.3.shown" = true;
      "browser.shell.checkDefaultBrowser" = false;
      "browser.shell.defaultBrowserCheckCount" = 1;
      "browser.startup.homepage_override.mstone" = "ignore";
      "browser.uitour.enabled" = false;
      "startup.homepage_override_url" = "";
      "trailhead.firstrun.didSeeAboutWelcome" = true;
      "browser.bookmarks.restore_default_bookmarks" = false;
      "browser.bookmarks.addedImportButton" = true;

      # Disable ads and sponsored sites
      "browser.newtabpage.activity-stream.showSponsored" = false;
      "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
      "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsored" = false;
      "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
      "browser.newtabpage.blocked" = lib.genAttrs [
        "4gPpjkxgZzXPVtuEoAL9Ig==" # Facebook
        "K00ILysCaEq8+bEqV/3nuw==" # Amazon
      ] (_: 1);

      # Disable telemetry
      "app.shield.optoutstudies.enabled" = false;
      "browser.discovery.enabled" = false;
      "browser.newtabpage.activity-stream.feeds.telemetry" = false;
      "browser.newtabpage.activity-stream.telemetry" = false;
      "browser.ping-centre.telemetry" = false;
      "datareporting.healthreport.service.enabled" = false;
      "datareporting.healthreport.uploadEnabled" = false;
      "datareporting.policy.dataSubmissionEnabled" = false;
      "datareporting.sessions.current.clean" = true;
      "devtools.onboarding.telemetry.logged" = false;
      "toolkit.telemetry.archive.enabled" = false;
      "toolkit.telemetry.bhrPing.enabled" = false;
      "toolkit.telemetry.enabled" = false;
      "toolkit.telemetry.firstShutdownPing.enabled" = false;
      "toolkit.telemetry.hybridContent.enabled" = false;
      "toolkit.telemetry.newProfilePing.enabled" = false;
      "toolkit.telemetry.prompted" = 2;
      "toolkit.telemetry.rejected" = true;
      "toolkit.telemetry.reportingpolicy.firstRun" = false;
      "toolkit.telemetry.server" = "";
      "toolkit.telemetry.shutdownPingSender.enabled" = false;
      "toolkit.telemetry.unified" = false;
      "toolkit.telemetry.unifiedIsOptIn" = false;
      "toolkit.telemetry.updatePing.enabled" = false;

      "identity.fxaccounts.enabled" = false; # Disable firefox accounts
      "signon.rememberSignons" = false; # Disable password saving prompt
      "privacy.trackingprotection.enabled" = true;
      "dom.security.https_only_mode" = true; # Enforce https by default
    };
  };
}
