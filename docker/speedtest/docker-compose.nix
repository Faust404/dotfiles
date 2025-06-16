{ pkgs, lib, ... }:

{

  # Containers
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      openspeedtest = {
        image = "openspeedtest/latest";
        ports = [ "3003:3000/tcp" ];
        log-driver = "journald";
      };
    };
  };

}
