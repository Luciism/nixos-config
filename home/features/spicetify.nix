{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
let
  cfg = config.features.spicetify;
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  options.features.spicetify.enable = mkEnableOption "Enable Spicetify";

  # imports = mkIf cfg.enable [
  #   inputs.spicetify-nix.homeManagerModules.default
  # ];

  config = mkIf cfg.enable {
    # nixpkgs.config.allowUnfreePredicate =
    #   pkg:
    #   builtins.elem (lib.getName pkg) [
    #     "spotify"
    #   ];
    #
    programs.spicetify = {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        shuffle
      ];
      enabledCustomApps = with spicePkgs.apps; [
        newReleases
        ncsVisualizer
      ];
      enabledSnippets = with spicePkgs.snippets; [
        rotatingCoverart
        pointer
      ];
      theme = spicePkgs.themes.text;
    };
  };
}
