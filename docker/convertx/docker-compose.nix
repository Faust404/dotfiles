{ config, pkgs, lib, ... }:

{

  # Containers
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      convertx = {
        image = "ghcr.io/c4illin/convertx";
        ports = [ "3002:3000/tcp" ];
        volumes = [
          "${config.users.users.faust.home}/docker_volumes/convertx/data:/app/data:rw"
        ];
        environmentFiles = [ 
          "${config.users.users.faust.home}/dotfiles/docker/convertx/.env"
        ];
        log-driver = "journald";
      };
    };
  };

}
