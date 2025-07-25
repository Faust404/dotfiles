# Auto-generated using compose2nix v0.3.1.
{ pkgs, lib, ... }:

{

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      gd-helper = {
        image = "index.docker.io/himavanth19/gd-helper";
        ports = [ "5002:5000/tcp" ];
        log-driver = "journald";
      };
    };
  };

}
