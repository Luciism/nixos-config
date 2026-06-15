{
  inputs,
  ...
}:
{
  imports = [
    ./home.nix
    ../features
    inputs.spicetify-nix.homeManagerModules.default
  ];

  features = {
    spicetify.enable = false;
    wine.enable = false;
  };
}
