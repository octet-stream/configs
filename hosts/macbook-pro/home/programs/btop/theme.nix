{ config, lib, ... }:
lib.mkIf config.programs.btop.enable {
  catppuccin.btop.enable = true;
}
