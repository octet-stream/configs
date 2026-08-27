{ self, ... }:
let
  userModuleKey = self.lib.mkUserModuleKey "macbook-pro" "octetstream";
in
{
  flake.modules.homeManager.${userModuleKey} =
    {
      pkgs,
      pkgsUnstable,
      ...
    }:
    let
      stablePackages = with pkgs; [
        vim
        bun
        deno
        rustup
        ookla-speedtest
        git-extras
        nginx-language-server
        iina

        (if pkgs.stdenv.hostPlatform.isDarwin then vlc-bin else vlc)
      ];

      unstablePackages = with pkgsUnstable; [
        pulumi
        stripe-cli
        devenv
        dbeaver-bin

        # Work tools.
        codex
        codex-acp
        gh
      ];
    in
    {
      home.packages = stablePackages ++ unstablePackages;
    };
}
