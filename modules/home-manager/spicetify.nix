{
  pkgs,
  inputs,
  ...
}:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  cfg = config.modules.spicetify;
in
{
  options.modules.spicetify = {
    enable = mkEnableOption "Spicetify Configuration";
  }


  config = mkIf cfg.enable {
      programs.spicetify = {
        enable = true;

        enabledExtensions = with spicePkgs.extensions; [
          adblock
          hidePodcasts
          shuffle # shuffle+ (special characters are sanitized out of extension names)
        ];
        enabledCustomApps = with spicePkgs.apps; [
          newReleases
          ncsVisualizer
        ];
        enabledSnippets = with spicePkgs.snippets; [
          rotatingCoverart
          pointer
        ];

        # theme = spicePkgs.themes.hazy;
        theme = spicePkgs.themes.text;
        # colorScheme = "mocha";
      };
    }
}
