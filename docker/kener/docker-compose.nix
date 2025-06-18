{ config, pkgs, lib, ... }:

{

  # Agenix secrets
  age.secrets.kener.file = ../../secrets/kener.age;

  # Create directories and set permissions declaratively
  systemd.tmpfiles.rules = [
    "d ${config.users.users.faust.home}/docker_volumes/kener/data 0755 1000 1000 -"
    "d ${config.users.users.faust.home}/docker_volumes/kener/uploads 0755 1000 1000 -"
  ];

  # Containers
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      kener = {
        image = "rajnandan1/kener:latest";
        environmentFiles = [ config.age.secrets.kener.path ];
        volumes = [
          "${config.users.users.faust.home}/docker_volumes/kener/data:/app/database:rw"
          "${config.users.users.faust.home}/docker_volumes/kener/uploads:/app/uploads:rw"
        ];
        ports = [ "3004:3000/tcp" ];
        log-driver = "journald";
      };
    };
  };

}
