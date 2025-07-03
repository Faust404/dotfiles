{ config, pkgs, lib, ... }:

{

  # Containers
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      neverwinter_knights_server = {
        image = "urothis/nwserver:8193.37.15";
        environmentFiles = [ "/home/faust/dotfiles/docker/neverwinter_knights/.env" ];
        volumes = [
          "${config.users.users.faust.home}/docker_volumes/nwnee:/nwn/home:rw"
        ];
        ports = [ "5121:5121/udp" ];
        log-driver = "journald";
      };
    };
  };

}
