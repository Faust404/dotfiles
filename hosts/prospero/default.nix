{ config, lib, pkgs, dockerPath, ... }:

{
  nixpkgs.hostPlatform = "aarch64-linux";
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Prospero server specific modules
      (dockerPath + /caddy/caddy.nix)
      (dockerPath + /stirling_pdf/docker-compose.nix)
      (dockerPath + /dozzle/docker-compose.nix)
      (dockerPath + /filebrowser_quantum/docker-compose.nix)
      (dockerPath + /pingvin_share/docker-compose.nix)
      (dockerPath + /portainer/docker-compose.nix)
      (dockerPath + /wallos/docker-compose.nix)
      (dockerPath + /snippet_box/docker-compose.nix)
      (dockerPath + /firefly/docker-compose.nix)
      (dockerPath + /your_spotify/docker-compose.nix)
      (dockerPath + /foundry_main/docker-compose.nix)
      (dockerPath + /authelia/docker-compose.nix)
      (dockerPath + /karakeep/docker-compose.nix)
      (dockerPath + /convertx/docker-compose.nix)
      (dockerPath + /speedtest/docker-compose.nix)
      (dockerPath + /gatus/docker-compose.nix)
      (dockerPath + /homepage/docker-compose.nix)
      (dockerPath + /paperless_ngx/docker-compose.nix)
      (dockerPath + /immich/docker-compose.nix)
      (dockerPath + /gd_helper/docker-compose.nix)
      (dockerPath + /watchtower/docker-compose.nix)
      # (dockerPath + /website_change_detection/docker-compose.nix)

    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking = {
    hostName = "prospero-server";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [80 443];
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
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIClBxB+moolrLLqKSCC2d0Q7f5+y+4/NZYD/3+6DYBmw eddsa-key-20250712"
    ];
  };

  # Home manager user configuration
  home-manager.users.faust = import ./home.nix;

  # System packages
  environment.systemPackages = with pkgs; [
    wget
    curl
    openssl
  ];

  # Set timeout to 30 minutes
  security.sudo.extraConfig = ''
    Defaults        timestamp_timeout=30
  '';

  # To get VSCode to be able to connect from windows client
  programs.nix-ld.enable = true;

  # Enable SSH server
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "prohibit-password";
    };
  };

  # Docker Settings
  virtualisation.docker = {
    enable = true;
  };

  # Automatic cleanup
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 5d";
  nix.settings.auto-optimise-store = true;

  # Enable flakes (optional but recommended for modern NixOS usage)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.05";

}

