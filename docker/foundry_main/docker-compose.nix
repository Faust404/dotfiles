{ config, pkgs, lib, ... }:

{

  # Agenix secrets
  age.secrets.foundryvtt.file = ../../secrets/foundryvtt.age;

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      foundry_main = {
        image = "felddy/foundryvtt:13.350";
        ports = [ "30000:30000" ];
        environmentFiles = [ config.age.secrets.foundryvtt.path ];
        volumes = [
          "${config.users.users.faust.home}/docker_volumes/foundry_main_data:/data:rw"
        ];
        log-driver = "journald";
      };
    };
  };

}
