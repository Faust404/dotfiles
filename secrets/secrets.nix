let
  # Get your system's SSH public key: cat /etc/ssh/ssh_host_ed25519_key.pub
  netcup = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJTA+fuJ+GTCWkCH9kruapSRtvJ5njnEjhvrzBVfVonu";

  systems = [ netcup ];
in
{
  "your_spotify.age".publicKeys = systems;
  "foundryvtt.age".publicKeys = systems;
  "kener.age".publicKeys = systems;
  "convertx.age".publicKeys = systems;
  "karakeep.age".publicKeys = systems;
  "restic/password.age".publicKeys = systems;
  "restic/repo.age".publicKeys = systems;
  "restic/env.age".publicKeys = systems;
  "paperless_ngx.age".publicKeys = systems;
  "filebrowser.age".publicKeys = systems;
}