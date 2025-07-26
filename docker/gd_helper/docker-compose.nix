{ pkgs, lib, ... }:

{

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      gd-helper = {
        image = "index.docker.io/himavanth19/gd-helper:latest";
        ports = [ "5002:5000/tcp" ];
        labels = {
          "com.centurylinklabs.watchtower.enable" = "true";
        };
        log-driver = "journald";
      };
    };
  };

}
