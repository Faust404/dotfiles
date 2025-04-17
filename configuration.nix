{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking = {
    hostName = "nixos";                  # Define your hostname
    networkmanager.enable = true;        # Enable NetworkManager
  };

  # Set your time zone.
  time.timeZone = "Asia/Calcutta";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system (comment out if you don't need UI)
  # services.xserver.enable = true;

  # Define a user account
  users.users.faust = {
    isNormalUser = true;
    home = "/home/faust";
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPFGQAikISD6rSEWeG294uu4ZVOHt1B69gqBZPcud6cE himavanth.reddy19@gmail.com"
    ];
  };

  # System packages
  environment.systemPackages = with pkgs; [
    wget
    curl
  ];

  # To get VSCode to be able to connect from windows client
  programs.nix-ld.enable = true;

  # Enable SSH server
  services.openssh = {
  	enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  };

  # Enable docker
  virtualisation.docker.enable = true;

  # use docker without Root access (Rootless docker)
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # Automatic cleanup
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 5d";
  nix.settings.auto-optimise-store = true;

  # Enable flakes (optional but recommended for modern NixOS usage)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.11";

}

