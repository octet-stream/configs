{ config, ... }:
{
  programs.git = {
    settings.user = {
      email = "nick.kruchinin@gmail.com";
      name = "Nick K.";
    };

    signing = {
      format = "ssh";
      signByDefault = true;
      key = "${config.home.homeDirectory}/.ssh/id_gh_k.pub";
    };
  };
}
