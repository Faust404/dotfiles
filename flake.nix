{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
    system = "aarch64-linux"; # ARM 64-Bit CPU
    pkgs = nixpkgs.legacyPackages.${system};
    hostname = "nixos";
    username = "faust";

    in
    {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs system; };
        modules = [
          ./configuration.nix
          ./docker/stirling_pdf/docker-compose.nix
          ./docker/dozzle/docker-compose.nix
          ./docker/filebrowser/docker-compose.nix
          ./docker/pingvin_share/docker-compose.nix
          ];
      };

      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      };

    };
}
