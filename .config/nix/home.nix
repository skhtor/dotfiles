{ config, pkgs, ... }:
{
  home.username = "sassoonkuyumcian";
  home.homeDirectory = "/Users/sassoonkuyumcian";
  home.stateVersion = "23.11"; # Adjust to match the current Home Manager version

  programs.zsh = {
    enable = true;
    # Add your Zsh config here
  };

  # Add more packages or settings here
  home.packages = with pkgs; [
    htop
    bat
    # ...your user utilities
  ];
}
