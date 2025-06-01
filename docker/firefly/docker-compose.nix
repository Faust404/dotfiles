{ config, pkgs, lib, ... }:

{

  # Containers
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {

      firefly_iii_core = {
        image = "fireflyiii/core:latest";
        ports = [ "7000:8080" ];
        environmentFiles = [ 
          "${config.users.users.faust.home}/dotfiles/docker/firefly/.env"
        ];
        volumes = [
          "${config.users.users.faust.home}/docker_volumes/firefly_upload:/var/www/html/storage/upload:rw"
        ];
        dependsOn = [
          "firefly_iii_db"
        ];
        log-driver = "journald";
        extraOptions = [
          "--hostname=app"
          "--network-alias=app"
          "--network=firefly_firefly_iii"
        ];
      };

      firefly_iii_cron = {
        image = "alpine";
        cmd = [ "sh" "-c" "echo \"0 3 * * * wget -qO- http://app:8080/api/v1/cron/REPLACEME\" | crontab - && crond -f -L /dev/stdout" ];
        log-driver = "journald";
        extraOptions = [
          "--network-alias=cron"
          "--network=firefly_firefly_iii"
        ];
      };

      firefly_iii_db = {
        image = "mariadb:lts";
        environmentFiles = [ 
          "${config.users.users.faust.home}/dotfiles/docker/firefly/.db.env"
        ];
        volumes = [
          "${config.users.users.faust.home}/docker_volumes/firefly_db:/var/lib/mysql:rw"
        ];
        log-driver = "journald";
        extraOptions = [
          "--hostname=db"
          "--network-alias=db"
          "--network=firefly_firefly_iii"
        ];
      };

      firefly_iii_importer = {
        image = "fireflyiii/data-importer:latest";
        ports = [ "7001:8080" ];
        environmentFiles = [ 
          "${config.users.users.faust.home}/dotfiles/docker/firefly/.importer.env"
        ];
        dependsOn = [
          "firefly_iii_core"
        ];
        log-driver = "journald";
        extraOptions = [
          "--hostname=importer"
          "--network-alias=importer"
          "--network=firefly_firefly_iii"
        ];
      };

    };
  };

  # Systemd Services
  systemd.services = {

    docker-firefly_iii_core = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
        RestartMaxDelaySec = lib.mkOverride 90 "1m";
        RestartSec = lib.mkOverride 90 "100ms";
        RestartSteps = lib.mkOverride 90 9;
      };
      after = [
        "docker-network-firefly_firefly_iii.service"
      ];
      requires = [
        "docker-network-firefly_firefly_iii.service"
      ];
      partOf = [
        "docker-compose-firefly-root.target"
      ];
      wantedBy = [
        "docker-compose-firefly-root.target"
      ];
    };

    docker-firefly_iii_cron = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
        RestartMaxDelaySec = lib.mkOverride 90 "1m";
        RestartSec = lib.mkOverride 90 "100ms";
        RestartSteps = lib.mkOverride 90 9;
      };
      after = [
        "docker-network-firefly_firefly_iii.service"
      ];
      requires = [
        "docker-network-firefly_firefly_iii.service"
      ];
      partOf = [
        "docker-compose-firefly-root.target"
      ];
      wantedBy = [
        "docker-compose-firefly-root.target"
      ];
    };

    docker-firefly_iii_db = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
        RestartMaxDelaySec = lib.mkOverride 90 "1m";
        RestartSec = lib.mkOverride 90 "100ms";
        RestartSteps = lib.mkOverride 90 9;
      };
      after = [
        "docker-network-firefly_firefly_iii.service"
      ];
      requires = [
        "docker-network-firefly_firefly_iii.service"
      ];
      partOf = [
        "docker-compose-firefly-root.target"
      ];
      wantedBy = [
        "docker-compose-firefly-root.target"
      ];
    };

    docker-firefly_iii_importer = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
        RestartMaxDelaySec = lib.mkOverride 90 "1m";
        RestartSec = lib.mkOverride 90 "100ms";
        RestartSteps = lib.mkOverride 90 9;
      };
      after = [
        "docker-network-firefly_firefly_iii.service"
      ];
      requires = [
        "docker-network-firefly_firefly_iii.service"
      ];
      partOf = [
        "docker-compose-firefly-root.target"
      ];
      wantedBy = [
        "docker-compose-firefly-root.target"
      ];
    };

  };

  # Networks
  systemd.services."docker-network-firefly_firefly_iii" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "docker network rm -f firefly_firefly_iii";
    };
    script = ''
      docker network inspect firefly_firefly_iii || docker network create firefly_firefly_iii --driver=bridge
    '';
    partOf = [ "docker-compose-firefly-root.target" ];
    wantedBy = [ "docker-compose-firefly-root.target" ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."docker-compose-firefly-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
