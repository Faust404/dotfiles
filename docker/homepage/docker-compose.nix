{ config, pkgs, lib, ... }:

{

  # Create directories and set permissions declaratively
  systemd.tmpfiles.rules = [
    "d ${config.users.users.faust.home}/docker_volumes/homepage/config 0755 1000 1000 -"
  ];

  # Containers
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      homepage = {
        image = "ghcr.io/gethomepage/homepage:latest";
        ports = [ "3004:3000" ];
        environment = {
          "HOMEPAGE_ALLOWED_HOSTS" =  "home.hreddy.in";
        };
        volumes = [
          "${config.users.users.faust.home}/docker_volumes/homepage/config:/app/config:rw"
        ];
        log-driver = "journald";
      };
    };
  };

}
