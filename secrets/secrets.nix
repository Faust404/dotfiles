let
  # Get your system's SSH public key: cat /etc/ssh/ssh_host_ed25519_key.pub
  netcup = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJTA+fuJ+GTCWkCH9kruapSRtvJ5njnEjhvrzBVfVonu";

  systems = [ netcup ];
in
{
  "your_spotify.age".publicKeys = systems;
  "foundryvtt.age".publicKeys = systems;
  "kener.age".publicKeys = systems;
}