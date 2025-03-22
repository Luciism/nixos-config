{
  config,
  pkgs,
  inputs,
  ...
}:
{
  users.users.lucism = {
    isNormalUser = true;
    description = "Lucism";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    packages = [inputs.home-manager.packages.${pkgs.system}.default];
  };

}
