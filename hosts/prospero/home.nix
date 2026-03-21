{ config, pkgs, ... }:

{
  home.username = "faust";
  home.homeDirectory = "/home/faust";

  # Packages to install for your user
  home.packages = with pkgs; [
    # Development
    git
    vim

    # Packages
    comma

    # CLI utilities
    eza
    unzip
    p7zip
    compose2nix
  ];

  # Git config
  programs.git = {
    enable = true;
    userName = "Faust404";
    userEmail = "himavanth.reddy19@gmail.com";
    extraConfig = {
      credential.helper = "oauth";
      init.defaultBranch = "main";
      core.editor = "vim";
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      # Control ls output
      ls = "ls --color=auto";
      la = "ls -la";
      l = "ls -CF";
      "l." = "ls -d .* --color=auto";

      # Git aliases
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline";

      # Navigation
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";

      # Do not delete / or prompt if deleting more than 3 files at a time
      rm = "rm -I --preserve-root";
      
      # Confirmation
      mv = "mv -i";
      cp = "cp -i";
      ln = "ln -i";

      # System aliases
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles/.#prospero --show-trace";
      hm = "home-manager switch";
      
      # Docker aliases
      docker = "sudo docker";
      dps = "docker ps -a";
      drm = "docker rm -f";
      dimg = "docker images";
      drmi = "docker rmi";
      dlog = "docker logs -f";
      dexec = "docker exec -it";
      dprune = "docker system prune -af --volumes";
      dclean = "docker container prune -f && docker image prune -f && docker network prune -f && docker volume prune -f";
      dtop = "docker stats -all";

      # Misc
      grep = "grep --color=auto";
      fgrep = "fgrep --color=auto";
      egrep = "egrep --color=auto";
    };

  };

  # This value determines the Home Manager release that your configuration is compatible with.
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

}