{ config, ... }:
{
  programs.git = {
    userName = "Nick K.";
    userEmail = "nick.kruchinin@gmail.com";

    signing = {
      format = "ssh";
      signByDefault = true;
      key = "${config.home.homeDirectory}/.ssh/id_gh_k.pub";
    };
  };
}
