{
  imports = [
    ../common
    ./configuration.nix
    ./hardware-configuration.nix
  ];

  config.users.lucism-minimal.enable = true;
}
