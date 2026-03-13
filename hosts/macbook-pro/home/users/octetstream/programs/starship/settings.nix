{
  programs.starship.settings = {
    add_newline = false; # Disable newline between prompts (because it adds one at the beginning of a new session)
    command_timeout = 3600;

    character = {
      success_symbol = "[➜](bold green)";
      error_symbol = "[➜](bold red)";
    };
  };
}
