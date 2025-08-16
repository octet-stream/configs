{ config, ... }:
let
  publicKeyPath = "${config.home.homeDirectory}/.ssh/id_gh_k.pub";
  userEmail = "nick.kruchinin@gmail.com";
in
{
  programs.git = {
    userName = "Nick K.";
    userEmail = userEmail;

    signing = {
      format = "ssh";
      signByDefault = true;
      key = publicKeyPath;
    };
  };
}
