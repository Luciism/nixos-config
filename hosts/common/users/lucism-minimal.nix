{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
with lib;
let
  cfg = config.users.lucism;
in
{
  options.users.lucism-minimal.enable = mkEnableOption "Enable lucism user with minimal features";

  config = mkIf cfg.enable {
    users.users.lucism = {
      isNormalUser = true;
      description = "Lucism";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
      packages = [ inputs.home-manager.packages.${pkgs.system}.default ];
    };

    home-manager.users.lucism = import ../../../home/lucism-minimal/lucism.nix;
  };
}
