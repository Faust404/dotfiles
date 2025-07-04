{ config, pkgs, lib, ... }:

{
  # Containers
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {

      hbbr = {
        image = "rustdesk/rustdesk-server:latest";
        volumes = [
          "${config.users.users.faust.home}/docker_volumes/rustdesk/data:/root:rw"
        ];
        cmd = [ "hbbr" ];
        log-driver = "journald";
        extraOptions = [
          "--network=host"
        ];
      };

      hbbs = {
        image = "rustdesk/rustdesk-server:latest";
        environment = {
          "ALWAYS_USE_RELAY" = "Y";
        };
        volumes = [
          "${config.users.users.faust.home}/docker_volumes/rustdesk/data:/root:rw"
        ];
        cmd = [ "hbbs" ];
        dependsOn = [
          "hbbr"
        ];
        log-driver = "journald";
        extraOptions = [
          "--network=host"
        ];
      };

    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 21115 21116 21117 21118 21119 ];
    allowedUDPPorts = [ 21116 ];
  };

}
