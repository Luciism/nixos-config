{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{
  home.username = "lucism";
  home.homeDirectory = "/home/${config.home.username}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
      "spotify"
      "vscode"
      "minecraft-launcher"
      "steam"
      "steam-original"
      "steam-unwrapped"
      "steam-run"
      "mongodb-compass"
    ];

  home.packages = with pkgs; [
    # gimp
    libreoffice
    discord
    (vesktop.overrideAttrs (
      finalAttrs: previousAttrs: {
        desktopItems = [
          ((builtins.elemAt previousAttrs.desktopItems 0).override { icon = "discord"; })
        ];
      }
    ))
    mongodb-compass
    obs-studio
    firefox-devedition
    cheese
    prismlauncher
    figma-linux
    docker-client
    uv
    vscode
    gnome-clocks
    filezilla
    easyeffects
    pavucontrol
    wezterm
  ];

  programs.starship = {
    enable = true;
    enableBashIntegration = true; # or enableZshIntegration, etc.
    settings = {
      # Optional: customize configuration
      format = "$all$character";
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };
    };
  };

  programs.tmux = {
    enable = true;
    shell = "${pkgs.bash}/bin/bash";
  };

  # For nixd LSP to recognize what nixpkgs version I use
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
