{ config, pkgs, ... }:

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
        extraConfig = ''
        forward_auth localhost:9091 {
            uri /api/authz/forward-auth
            copy_headers Remote-User Remote-Groups Remote-Email Remote-Name
          }
        reverse_proxy localhost:8081
      '';
      };

      # File Browser Quantum
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
        extraConfig = ''
        forward_auth localhost:9091 {
            uri /api/authz/forward-auth
            copy_headers Remote-User Remote-Groups Remote-Email Remote-Name
          }
        reverse_proxy localhost:5000
      '';
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

      # Authelia
      "auth.hreddy.in" = {
        extraConfig = "reverse_proxy localhost:9091";
      };

      # Authelia
      "lldap.hreddy.in" = {
        extraConfig = "reverse_proxy localhost:17170";
      };

      # Karakeep
      "karakeep.hreddy.in" = {
        extraConfig = "reverse_proxy localhost:3001";
      };

      # ConvertX
      "convertx.hreddy.in" = {
        extraConfig = "reverse_proxy localhost:3002";
      };

      # Open Speedtest
      "speedtest.hreddy.in" = {
        extraConfig = "reverse_proxy localhost:3003";
      };

      # Gatus Status Page
      "status.hreddy.in" = {
        extraConfig = "reverse_proxy localhost:8084";
      };

      # Homepage
      "home.hreddy.in" = {
        extraConfig = "reverse_proxy localhost:3004";
      };

      # Paperless-ngx
      "paperless.hreddy.in" = {
        extraConfig = "reverse_proxy localhost:8001";
      };

      # Paperless-ngx
      "immich.hreddy.in" = {
        extraConfig = "reverse_proxy localhost:2283";
      };

    };
  };
}