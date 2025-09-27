# Adds pinned tabs to browser settings
{ lib, ... }:
let
  abs = x: if x < 0 then 0 - x else x;

  padPinnedSitesList =
    amount: builtins.genList (i: { url = "about:blank?${toString (i + 1)}"; }) amount;

  genPinnedSites =
    input:
    let
      limit = 8 * 4;
      inputLength = builtins.length input;
      rows = abs (builtins.ceil (inputLength / 8.0));
      list = input ++ padPinnedSitesList (8 * rows - inputLength);
      enable = (builtins.length list) > 0;
    in
    assert lib.assertMsg (inputLength <= limit)
      "The limit of pinned sites is exceeded. Expected ${toString limit}, but the list has ${toString inputLength} elements";
    {
      inherit list enable rows;
    };

  pinned = genPinnedSites [
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
      label = "Solid";
      url = "https://www.solidjs.com/";
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

    {
      label = "React Router";
      url = "https://reactrouter.com/";
    }

    {
      label = "Next.js";
      url = "https://nextjs.org/";
    }

    {
      label = "Nuxt";
      url = "https://nuxt.com/";
    }
  ];
in
{
  programs.firefox.profiles.default.settings = {
    # Disable ads and sponsored sites
    "browser.newtabpage.activity-stream.showSponsored" = false;
    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
    "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsored" = false;
    "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
    "browser.newtabpage.blocked" = lib.genAttrs [
      "4gPpjkxgZzXPVtuEoAL9Ig==" # Facebook
      "K00ILysCaEq8+bEqV/3nuw==" # Amazon
    ] (_: 1);

    # Pinned sites
    "browser.newtabpage.activity-stream.feeds.topsites" = pinned.enable;
    "browser.newtabpage.activity-stream.topSitesRows" = pinned.rows;
    "browser.newtabpage.pinned" = builtins.toJSON pinned.list;
  };
}
