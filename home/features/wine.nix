{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.features.wine;
in
{
  options.features.wine.enable = mkEnableOption "Enable Wine";
  config = mkIf cfg.enable {
   home.packages = with pkgs; [
      wineWow64Packages.stable
      winetricks
      mono
    ];

    home.sessionVariables.WINEPREFIX = "/home/${config.home.username}/.wine";
    home.sessionVariables.WINEARCH = "win32";
  };
}
