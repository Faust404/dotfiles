{ config, pkgs, ... }:

{

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      filebrowser = {
        image = "hurlenko/filebrowser";
        ports = [ "8082:8080" ];
        volumes = [
          "${config.users.users.faust.home}/docker_volumes/filebrowser/config/:/config:rw"
          # "${config.users.users.faust.home}/docker_volumes/foundry_test_data:/data/foundry_test"
          # "${config.users.users.faust.home}/docker_volumes/filebrowser/config/:/config"
        ];
        environment = {
          "FB_BASEURL" = "/filebrowser";
        };
        log-driver = "journald";
      };
    };
  };

}
