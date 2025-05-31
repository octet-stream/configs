{ config, lib, ... }:
lib.mkIf config.programs.bat.enable {
  catppuccin.bat.enable = true;
}
