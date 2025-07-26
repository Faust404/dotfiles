{ pkgs, lib, ... }:

{

  # Containers
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      watchtower = {
        image = "containrrr/watchtower";
        environment = {
          "WATCHTOWER_CLEANUP" = "true";
          "WATCHTOWER_LABEL_ENABLE" = "true";
          "WATCHTOWER_POLL_INTERVAL" = "900";
          "WATCHTOWER_ROLLING_RESTART" = "true";
        };
        volumes = [
          "/var/run/docker.sock:/var/run/docker.sock:rw"
        ];
        log-driver = "journald";
      };
    };
  };

}
