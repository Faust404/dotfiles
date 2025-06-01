{ config, pkgs, lib, ... }:

{

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      foundry_main = {
        image = "felddy/foundryvtt:12.343";
        ports = [ "30000:30000" ];
        environmentFiles = [ 
          "${config.users.users.faust.home}/dotfiles/docker/foundry_main/.env"
        ];
        volumes = [
          "${config.users.users.faust.home}/docker_volumes/foundry_main_data:/data:rw"
        ];
        log-driver = "journald";
      };
    };
  };

}
