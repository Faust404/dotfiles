{ config, pkgs, lib, ... }:

{

  services.syncthing = {
    enable = true;
    user = "faust";
    # TO DO: Move syncthing config to seperate dir as this is not a docker container
    dataDir = "${config.users.users.faust.home}/docker_volumes/syncthing";
    configDir = "${config.users.users.faust.home}/docker_volumes/syncthing";
    openDefaultPorts = true;
    guiAddress = "127.0.0.1:8384";

    settings = {
      gui = {
        # user = "admin";
        # password = "admin";
        insecureAllowFrameLoading = false;
        insecureSkipHostCheck = true;
      };

      # Add devices to sync with
      devices = {
        "windows-pc" = {
          id = "P2EUIIV-FQKFDYR-HSNHHMW-K6YP3ON-FJIAQYJ-KJCBAAV-XHIJ5IT-TTWWVAZ";
          introducer = false;
        };
      };

      # Folders to sync
      folders = {
        "photos" = {
          path = "${config.users.users.faust.home}/photos";
          devices = [ "windows-pc" ];
          ignorePerms = false;
        };
      };
    };
  };
}