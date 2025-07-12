{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    agenix.url = "github:ryantm/agenix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ez-configs = {
      url = "github:ehllie/ez-configs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.ez-configs.flakeModule
      ];
      
      systems = [ "aarch64-linux" "x86_64-linux" ];
      
      # Configure ez-configs
      ezConfigs = {
        root = ./.;

        nixos.configurationsDirectory = ./hosts;
        nixos.modulesDirectory = ./modules;
        
        # Global arguments passed to all configurations
        globalArgs = {
          inherit inputs;
          secretsPath = ./secrets;
          dockerPath = ./docker;
        };
      };

      perSystem = { config, self', inputs', pkgs, system, ... }: {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nil
            nixpkgs-fmt
            inputs.agenix.packages.${system}.default
          ];
        };
      };
    };

}
