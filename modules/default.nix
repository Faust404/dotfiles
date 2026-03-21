{ inputs, pkgs, ... }:
{
  imports = [
    inputs.agenix.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
    # ./restic.nix
  ];
  
  # Make agenix available system-wide
  environment.systemPackages = [ inputs.agenix.packages.${pkgs.system}.default ];

  # Basic home-manager setup
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = { inherit inputs; };
}