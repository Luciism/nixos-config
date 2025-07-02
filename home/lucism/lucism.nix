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
    spicetify.enable = true;
    wine.enable = false;
  };
}
