{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    agenix.url = "github:ryantm/agenix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, agenix, home-manager, ... }@inputs:
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
          agenix.nixosModules.default
          { environment.systemPackages = [ agenix.packages.aarch64-linux.default ]; }
          ./configuration.nix
          ./docker/stirling_pdf/docker-compose.nix
          ./docker/dozzle/docker-compose.nix
          ./docker/filebrowser/docker-compose.nix
          ./docker/pingvin_share/docker-compose.nix
          ./docker/portainer/docker-compose.nix
          ./docker/wallos/docker-compose.nix
          ./docker/snippet_box/docker-compose.nix
          ./docker/firefly/docker-compose.nix
          ./docker/your_spotify/docker-compose.nix
          ./docker/foundry_main/docker-compose.nix
          ];
      };

      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      };

    };
}
