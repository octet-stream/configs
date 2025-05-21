{ config, lib, ... }:
lib.mkIf config.programs.ghostty.enable {
  catppuccin.ghostty.enable = true;
}
