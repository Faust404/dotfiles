{ inputs, pkgs, secretsPath, ... }:
{
  imports = [
    inputs.agenix.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
    ./restic.nix
    ./syncthing.nix
  ];
  
  # Make agenix available system-wide
  environment.systemPackages = [ inputs.agenix.packages.${pkgs.system}.default ];

  # Pass secretsPath to other modules
  _module.args.secretsPath = secretsPath;
  
  # Basic home-manager setup
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = { inherit inputs; };
}