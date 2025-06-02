{ config, lib, pkgs, ... }:

{
  services.caddy = {
    enable = true;
    virtualHosts = {
      # Stirling PDF
      "stirling.hreddy.in" = {
        extraConfig = "reverse_proxy localhost:8080";
      };
      
      # Dozzle
      "dozzle.hreddy.in" = {
        extraConfig = "reverse_proxy localhost:8081";
      };
      
      # Filebrowser
      "filebrowser.hreddy.in" = {
        extraConfig = "reverse_proxy localhost:8082";
      };
      
      # Pingvin Share
      "pingvin.hreddy.in" = {
        extraConfig = "reverse_proxy localhost:3000";
      };
      
      # Portainer
      "portainer.hreddy.in" = {
        extraConfig = "reverse_proxy localhost:9000";
      };
      
      # Wallos
      "wallos.hreddy.in" = {
        extraConfig = "reverse_proxy localhost:8083";
      };
      
      # Snippets
      "snippets.hreddy.in" = {
        extraConfig = "reverse_proxy localhost:5000";
      };
      
      # Firefly Service
      "firefly.hreddy.in" = {
        extraConfig = "reverse_proxy localhost:7000";
      };
      
      # Firefly Importer
      "importer.hreddy.in" = {
        extraConfig = "reverse_proxy localhost:7001";
      };
      
      # Your Spotify Server
      "musicserver.hreddy.in" = {
        extraConfig = "reverse_proxy localhost:6000";
      };
      
      # Your Spotify Client
      "music.hreddy.in" = {
        extraConfig = "reverse_proxy localhost:6001";
      };
      
      # Foundry VTT Main Server
      "dnd.hreddy.in" = {
        extraConfig = "reverse_proxy localhost:30000";
      };
    };
  };
}