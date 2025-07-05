{ config, pkgs, lib, ... }:

{

  # Agenix secrets
  age.secrets.paperless.file = ../../secrets/paperless_ngx.age;

  # Containers
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {

      paperless-webserver = {
        image = "ghcr.io/paperless-ngx/paperless-ngx:latest";
        environmentFiles = [ config.age.secrets.paperless.path ];
        volumes = [
          "${config.users.users.faust.home}/docker_volumes/paperless_ngx/consume:/usr/src/paperless/consume:rw"
          "${config.users.users.faust.home}/docker_volumes/paperless_ngx/data:/usr/src/paperless/data:rw"
          "${config.users.users.faust.home}/docker_volumes/paperless_ngx/export:/usr/src/paperless/export:rw"
          "${config.users.users.faust.home}/docker_volumes/paperless_ngx/media:/usr/src/paperless/media:rw"
        ];
        ports = [
          "8001:8000/tcp"
        ];
        dependsOn = [
          "paperless-broker"
        ];
        log-driver = "journald";
        extraOptions = [
          "--network-alias=webserver"
          "--network=paperless_default"
        ];
      };

      paperless-broker = {
        image = "docker.io/library/redis:8";
        volumes = [
          "${config.users.users.faust.home}/docker_volumes/paperless_ngx/redisdata:/data:rw"
        ];
        log-driver = "journald";
        extraOptions = [
          "--network-alias=broker"
          "--network=paperless_default"
        ];
      };

    };
  };

}
