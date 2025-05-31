# Auto-generated using compose2nix v0.3.1.
{ pkgs, lib, ... }:

{

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      dozzle = {
        image = "amir20/dozzle:latest";
        ports = [ "8081:8080" ];
        volumes = [
          "/var/run/docker.sock:/var/run/docker.sock:rw"
        ];
        log-driver = "journald";
      };
    };
  };

}
