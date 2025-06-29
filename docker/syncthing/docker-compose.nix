{ config, pkgs, lib, ... }:

{

  # Containers
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      syncthing = {
        image = "syncthing/syncthing";
        ports = [ "8384:8384/tcp" ];
        environment = {
          "PGID" = "1000";
          "PUID" = "1000";
        };
        volumes = [
          "${config.users.users.faust.home}/docker_volumes/syncthing/st-sync:/var/syncthing:rw"
        ];
        log-driver = "journald";
      };
    };
  };

}
