{
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

  home-manager.users.lucism =
    import ../../../home/lucism/lucism.nix;
}
