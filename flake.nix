{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    poetry2nix.url = "github:nix-community/poetry2nix";
    flake-utils.url = "github:numtide/flake-utils";

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

            # Python 3.10 and Poetry
            python310
            poetry
            stdenv.cc.cc.lib # Ensures libstdc++.so.6 is available
          ];

          shellHook = ''
            # Ensure Poetry uses the correct Python version from Nix
            poetry env use $(which python) 2>/dev/null || true
            echo "Python version: $(python --version)"
            echo "Poetry available: $(poetry --version)"
          '';

        };
      };
    };

}
