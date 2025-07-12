{ secretsPath, config, pkgs, lib, ... }:

{

  # configure agenix secrets
  age.secrets = {
    "restic/repo" = {
      # file = ../secrets/restic/repo.age;
      file = secretsPath + /restic/repo.age;
      owner = "root";
      mode = "600";
    };
    "restic/password" = {
      # file = ../secrets/restic/password.age;
      file = secretsPath + /restic/password.age;
      owner = "root";
      mode = "600";
    };
    "restic/env" = {
      # file = ../secrets/restic/env.age;
      file = secretsPath + /restic/env.age;
      owner = "root";
      mode = "600";
    };
  };

  # configure restic backup services
  services.restic.backups = {
    backblaze = {
      initialize = true;

      environmentFile = config.age.secrets."restic/env".path;
      repositoryFile = config.age.secrets."restic/repo".path;
      passwordFile = config.age.secrets."restic/password".path;

      paths = [
        "${config.users.users.faust.home}/dotfiles"
        "${config.users.users.faust.home}/docker_volumes"
        "${config.users.users.faust.home}/photos"
      ];

      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 5"
        "--keep-monthly 12"
      ];
    };
  };

}