{ config, pkgs, lib, ... }:

{

  # Containers
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      gatus = {
        image = "twinproduction/gatus:latest";
        ports = [ "8084:8080/tcp" ];
        volumes = [
          "${config.users.users.faust.home}/dotfiles/docker/gatus/:/config:rw"
          "${config.users.users.faust.home}/docker_volumes/gatus/data:/data:rw"
        ];
        log-driver = "journald";
      };
    };
  };

}
