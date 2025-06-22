{ config, pkgs, lib, ... }:

{

  # Agenix secrets
  age.secrets.filebrowser.file = ../../secrets/filebrowser.age;

  # Containers
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      filebrowser_quantum = {
        image = "gtstef/filebrowser";
        environment = {
          "FILEBROWSER_CONFIG" = "config.yaml";
          "FILEBROWSER_DATABASE" = "${config.users.users.faust.home}/docker_volumes/filebrowser/database.db";
        };
        environmentFiles = [ config.age.secrets.filebrowser.path ];
        volumes = [
          "${config.users.users.faust.home}/dotfiles/docker/filebrowser_quantum/config.yaml:/home/filebrowser/config.yaml:rw"
          "${config.users.users.faust.home}/dotfiles:/data/dotfiles"
          "${config.users.users.faust.home}/docker_volumes:/data/docker_volumes"
        ];
        ports = [ "8082:80/tcp" ];
        log-driver = "journald";
      };
    };
  };

}
