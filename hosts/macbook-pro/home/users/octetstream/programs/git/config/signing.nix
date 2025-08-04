{ config, ... }:
{
  programs.git = {
    signing = {
      format = "ssh";
      signByDefault = true;
      key = "${config.users.users.octetstream.home}/.ssh/id_gh_k.pub";
    };
    userName = "Nick K.";
    userEmail = null; # TODO: Add later
  };
}
