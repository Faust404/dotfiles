{ config, pkgs, ... }:

{

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      pingvin-share = {
        image = "stonith404/pingvin-share";
        ports = [ "3000:3000" ];
        volumes = [
          "${config.users.users.faust.home}/docker_volumes/pingvin_share/data:/opt/app/backend/data:rw"
          "${config.users.users.faust.home}/docker_volumes/pingvin_share/data/images:/opt/app/frontend/public/img:rw"
        ];
        log-driver = "journald";
      };
    };
  };

}
