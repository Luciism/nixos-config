{ pkgs, ... }:
{
  # Bootloader.
  # boot.loader.grub.enable = true;
  # boot.loader.grub.device = "nodev";
  # boot.loader.grub.useOSProber = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "local"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Pacific/Auckland";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_NZ.UTF-8";
    LC_IDENTIFICATION = "en_NZ.UTF-8";
    LC_MEASUREMENT = "en_NZ.UTF-8";
    LC_MONETARY = "en_NZ.UTF-8";
    LC_NAME = "en_NZ.UTF-8";
    LC_NUMERIC = "en_NZ.UTF-8";
    LC_PAPER = "en_NZ.UTF-8";
    LC_TELEPHONE = "en_NZ.UTF-8";
    LC_TIME = "en_NZ.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable NVIDIA
  services.xserver.videoDrivers = [ "nvidia" ];
  # hardware.nvidia.open = true;

  # hardware.bluetooth.enable = true; # enables support for Bluetooth
  # hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      # Policy.AutoEnable = true;
    };
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.lucism = {
  #   isNormalUser = true;
  #   description = "Lucism";
  #   extraGroups = [
  #     "networkmanager"
  #     "wheel"
  #     "docker"
  #   ];
  # };
  #
  # home-manager = {
  #   backupFileExtension = "backup";
  #   extraSpecialArgs = { inherit inputs pkgs; };
  #   useUserPackages = true;
  #   useGlobalPkgs = true;
  #   users = {
  #     "lucism" = import ./home.nix;
  #   };
  # };

  # Setup openvpn
  # services.openvpn.servers = {
  #   AU-1 = {
  #     config = "config /home/lucm.openvpn/configs/AU-1.ovpn";
  #     updateResolvConf = true;
  #   };
  #   AU-2 = {
  #     config = "config /home/lucism/.openvpn/configs/AU-2.ovpn";
  #     updateResolvConf = true;
  #   };
  #
  # };

  # Setup cloudflare tunnels
  services.cloudflared = {
    enable = true;
    # tunnels = {
    #   options = {
    #     originRequest = {
    #       noTLSVerify = true;
    #     };
    #     # credentialsFile = "${config.sops.secrets.cloudflared-creds.path}";
    #     credentialsFile = "/home/lucism/.cloudflared/cert.pem";
    #     default = "http_status:404";
    #   };
    #   "a3aa0f68-4b36-4864-9d04-88d0f171b561" = {
    #     credentialsFile = "/home/lucism/.cloudflared/cert.pem";
    #     ingress = {
    #       "local.lucism.dev" = {
    #         service = "http://127.0.0.1:8000";
    #       };
    #       "localsecure.lucism.dev" = {
    #         service = "https://127.0.0.1:8000";
    #       };
    #       "local3000.lucism.dev" = {
    #         service = "http://127.0.0.1:3000";
    #       };
    #     };
    #     default = "http_status:404";
    #   };
    # };
  };

  # services.onedrive.enable = true;
  # services.onedrive.package.args = [ "--disable-notifications" ];
  # Install firefox.

  # programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.partition-manager.enable = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # jetbrains.idea-community
    # partition-manager
    kdePackages.partitionmanager
    docker_26
    nodejs_22
    python313Full
    poetry
    poetryPlugins.poetry-plugin-shell
    # python3.12-poetry-plugin-shell
    zig
    gcc
    neovim
    git
    # onedrive
    ripgrep
    # basedpyright
    sqlite
    rustup
    rust-analyzer
    nixfmt-rfc-style
    cloudflared
    oh-my-posh
    nil
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    basedpyright
  ];

  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];
  #fonts.packages = with pkgs; [
  #    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; } )
  #     jetbrains-mono
  #];

  environment.sessionVariables = rec {
    SUDO_EDITOR = "nvim";
  };
  environment.variables.XDG_STATE_HOME = "/tmp";

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
  # nix.settings.experimental-features = [
  #   "nix-command"
  #   "flakes"
  # ];
}
