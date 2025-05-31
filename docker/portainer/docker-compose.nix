{ config, pkgs, ... }:

{

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      portainer = {
        image = "portainer/portainer-ce:latest";
        ports = [ "9000:9000" ];
        volumes = [
          "${config.users.users.faust.home}/docker_volumes/portainer/data:/data:rw"
          "/var/run/docker.sock:/var/run/docker.sock:rw"
        ];
        log-driver = "journald";
      };
    };
  };

}
