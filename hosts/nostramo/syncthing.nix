{ config, pkgs, lib, ... }:

{

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "himavanth";
    dataDir = "/home/himavanth";  # Default location for new sync folders
    configDir = "/home/himavanth/.config/syncthing";  # Where config.xml, keys live

    settings = {
      gui = {
        insecureAllowFrameLoading = false;
        insecureSkipHostCheck = true;
      };

      # Add devices to sync with
      devices = {
        "Desktop-Faust" = {
          id = "3K3JR42-LNPXHCY-GFCMO2V-3FSA4LZ-ETPDIGD-TDOYDWP-YI26OYK-EW5QWQS";
          introducer = false;
        };
      };

      # # Folders to sync
      # folders = {
      #   "test" = {
      #     path = "${config.users.users.himavanth.home}/Downloads/test";
      #     devices = [ "Desktop-Faust" ];
      #     ignorePerms = false;
      #   };
      # };

    };
  };
}