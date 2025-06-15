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
          "${config.users.users.faust.home}/docker_volumes/foundry_main_data:/data/foundry_main"
          "${config.users.users.faust.home}/dotfiles:/data/dotfiles"
        ];
        environment = {
          "FB_BASEURL" = "/filebrowser";
        };
        log-driver = "journald";
      };
    };
  };

}
