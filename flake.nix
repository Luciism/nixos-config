{
  description = "A very basic flake";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix/2f0cc0c110c25804cd2f6c167ab66f567941452c";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      spicetify-nix,
      home-manager,
      # sops-nix,
    }@inputs:
    {
      packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

      # homeManagerModules = import ./modules;
      nixosConfigurations = {
        local = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/desktop
            # ./hosts/desktop/spicetify.nix
            # sops-nix.nixosModules.sops
          ];
        };
      };
    };
}
