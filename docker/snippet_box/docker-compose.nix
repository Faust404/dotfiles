{ config, pkgs, ... }:

{

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      snippet-box = {
        image = "pawelmalak/snippet-box:arm"; # For ARM devices
        # image = "pawelmalak/snippet-box:arm"; # For AMD64 devices
        ports = [ "5000:5000" ];
        volumes = [
          "${config.users.users.faust.home}/docker_volumes/snippet_box/data:/app/data:rw"
        ];
        log-driver = "journald";
      };
    };
  };

}
