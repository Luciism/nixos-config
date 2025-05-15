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

  config = {
    features = {
      spicetify.enable = true;
    };
  };
}
