{ config, pkgs, ... }:

{
  home.username = "faust";
  home.homeDirectory = "/home/faust";

  # Packages to install for your user
  home.packages = with pkgs; [
    # Development
    git
    vim

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
      d = "docker";
      dc = "docker-compose";
      dps = "docker ps";

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