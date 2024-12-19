{
  pkgs,
  inputs,
  ...
}:
{
  users.users.minipcowner = {
    isNormalUser = true;
    description = "MinipcOwner";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = [inputs.home-manager.packages.${pkgs.system}.default];
  };

  home-manager.users.minipcowner =
    import ../../../home/minipcowner/minipcowner.nix;
}
