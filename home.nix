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
    # htop

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

  # Example: linking an existing file
  # ".config/some-app/config".source = ./dotfiles/some-app-config;

  # This value determines the Home Manager release that your
  # configuration is compatible with. Do not change unless you know what
  # you're doing.
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

}