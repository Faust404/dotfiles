{ config, pkgs, ... }:

{

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      stirling-pdf = {
        image = "docker.stirlingpdf.com/stirlingtools/stirling-pdf:latest";
        autoStart = true;
        ports = [ "8080:8080" ];
        volumes = [
          "${config.users.users.faust.home}/docker_volumes/StirlingPDF/trainingData:/usr/share/tessdata" # Required for extra OCR languages
          "${config.users.users.faust.home}/docker_volumes/StirlingPDF/extraConfigs:/configs"
          "${config.users.users.faust.home}/docker_volumes/StirlingPDF/customFiles:/customFiles/"
          "${config.users.users.faust.home}/docker_volumes/StirlingPDF/logs:/logs/"
          "${config.users.users.faust.home}/docker_volumes/StirlingPDF/pipeline:/pipeline/"
        ];
        environment = {
          DOCKER_ENABLE_SECURITY = "false";
          SECURITY_ENABLELOGIN = "false";
          LANGS = "en_US,en_GB";
          SYSTEM_DEFAULTLOCALE = "en-US";
          UI_APPNAME = "Stirling-PDF-OCI";
          UI_HOMEDESCRIPTION = "PDF tools via OCI containers";
        };
        log-driver = "journald";
      };
    };
  };

}