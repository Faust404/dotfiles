{ config, pkgs, ... }:

{

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      wallos = {
        image = "bellamy/wallos:latest";
        ports = [ "8083:80" ];
        volumes = [
          "${config.users.users.faust.home}/docker_volumes/wallos/db:/var/www/html/db:rw"
          "${config.users.users.faust.home}/docker_volumes/wallos/logos:/var/www/html/images/uploads/logos:rw"
        ];
        log-driver = "journald";
      };
    };
  };

}
